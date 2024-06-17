import 'package:application/main.dart';
import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/music_entry_convertor.dart';
import 'package:application/models/convertors/scored_entry_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/default_report_info.dart';
import 'package:application/services/api_service.dart';
import 'package:application/services/local_storage.dart';
import 'package:application/time_utils.dart';
import 'package:application/widgets/prompt/prompt_setting_modal.dart';
import 'package:application/widgets/show_snackbar.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

class ADT {
  static run({
    required String reportId,
    required String musicId,
    required String filePath,
    String? projectTitle,
    required List<MusicEntry> answer,
    required PromptOption option,
    int? measureCnt,
  }) async {
    if (option.type == ReportType.drill && measureCnt == null) {
      throw Exception('measure count is not given for drill');
    }
    // 다시 채점할 때 다시 비워놓기
    if (option.type == ReportType.full) {
      await (database.update(database.practiceInfos)
            ..where((tbl) => tbl.id.equals(reportId)))
          .writeReturning(
        const PracticeInfosCompanion(
          isNew: drift.Value(false),
          score: drift.Value(null),
          accuracyCount: drift.Value(null),
          result: drift.Value(null),
        ),
      );
    }

    ADTApiResponse? result = await ApiService.getADTResult(dataPath: filePath);

    if (result == null) {
      showGlobalSnackbar('오류가 발생했습니다.');
      return;
    }

// 결과 모델 생성
    var adt = ADTResultModel(
        bpm: option.currentBPM, transcription: result.transcription);

    await adt.calculateWithAnswer(answer);

    if (option.type == ReportType.full) {
      // 완곡인 경우 그대로 넣기
      await (database.update(database.practiceInfos)
            ..where((tbl) => tbl.id.equals(reportId)))
          .write(
        PracticeInfosCompanion(
          isNew: const drift.Value(true),
          score: drift.Value(adt.score),
          accuracyCount: drift.Value(adt.accuracyCount),
          componentCount: drift.Value(adt.componentCount),
          transcription: drift.Value(adt.transcription),
          result: drift.Value(adt.result),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );

      if (option.type == ReportType.full) {
        pnService.showNotification(projectTitle ?? "", reportId);
      }
    } else {
      List<List<ScoredEntry>> results = [];
      List<int> scores = [];

      double offset =
          TimeUtils.getSecPerBeat(option.currentBPM) * 4 * measureCnt!;

      adt.result.map((e) => print(e.toJson())).toList();

      filterTs(double ts, int i) {
        var flag1 = ts > i * offset;
        var flag2 = ts <= (i + 1) * offset;

        if (i == 0) {
          return flag2;
        } else if (i == measureCnt - 1) {
          return flag1;
        }
        return flag1 && flag2;
      }

      /// TODO: 이 밑으로 점검하기
      for (var i = 0; i < option.count; i++) {
        var transcription = List<ScoredEntry>.from(
          adt.result.where((e) => filterTs(e.ts, i)),
        );

        results.add(transcription);
        var score = ADTResultModel.calculateScore(
            AccuracyCount.fromScoredEntries(transcription));

        scores.add(score);
      }
      print(scores);

      await (database.update(database.drillReportInfos)
            ..where((tbl) => tbl.id.equals(reportId)))
          .write(
        DrillReportInfosCompanion(
          isNew: const drift.Value(true),
          scores: drift.Value(scores),
          transcription: drift.Value(result.transcription),
          results: drift.Value(results),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );
    }
  }

  static Future runWithId(String practiceId, String projectTitle) {
    return Future.wait(
            [LocalStorage.getLocalPath(), database.getADTRequest(practiceId)])
        .then((futureList) async {
      var requestInfo = futureList[1] as ADTRequestViewData;

      return ADT.run(
        filePath: "${futureList[0]}/$practiceId.wav",
        musicId: requestInfo.musicId!,
        reportId: practiceId,
        answer: requestInfo.musicEntries,
        option: PromptOption(type: ReportType.full, bpm: requestInfo.bpm),
        projectTitle: projectTitle,
      );
    });
  }
}

class ADTResultModel {
  final List<MusicEntry> transcription;
  final int bpm;
  late final List<MusicEntry> _buffer;
  final AccuracyCount accuracyCount = AccuracyCount();
  final ComponentCount componentCount = ComponentCount();
  late final double initBound, minBound, maxBound;
  double delay = 0;
  late final List<ScoredEntry> result;
  List<ScoredEntry> get remainingList =>
      result.where((element) => element.type == AccuracyType.miss).toList();

  int score = 0;

  ADTResultModel({this.transcription = const [], required this.bpm})
      : _buffer = List<MusicEntry>.from(transcription.map(
            (e) => e.copyWith(ts: e.ts - TimeUtils.getSecPerBeat(bpm) * 4)));

  ///분모: 전부 정답 + 박자 정답 + 음정 정답 + 오답 + miss<br>
  ///분자: 전부 정답 + 박자 정답 * **0.8** + 음정 정답 * **0.4**
  static calculateScore(AccuracyCount acc) {
    var divisor = acc.correct +
        acc.wrongComponent +
        acc.wrongTiming +
        // acc.wrong +
        acc.miss;

    if (divisor == 0) {
      return 0;
    }
    return (100 *
            (acc.correct + acc.wrongComponent * 0.8 + acc.wrongTiming * 0.6)) ~/
        divisor;
  }

  _setScore() {
    score = calculateScore(accuracyCount);
  }

  _setComponentCount() {
    // component count 세기
    for (var type in DrumComponent.values) {
      componentCount.setByType(
          type,
          result
              .where((e) =>
                  e.pitch == type.adtKey && e.type == AccuracyType.correct)
              .length);
    }
  }

  /// 채점 기준에 맞추어 나누기
  _classify(AccuracyType accType) {
    var defaultGap = accType == AccuracyType.wrongTiming ? maxBound : minBound;
    var count = 0;

    // 우선 박자 / 피치 모두 맞는 경우만 채점.
    for (var answer in remainingList) {
      var matchedIdx = -1;
      var gap = defaultGap;

      for (var idx = 0; idx < _buffer.length; idx++) {
        var value = _buffer[idx];
        var diff = answer.ts + delay - value.ts;

        // 피치가 맞아야 하는 타입인데 안 맞을 때 (correct, wrong timing)
        if (accType != AccuracyType.wrongComponent &&
            answer.pitch != value.pitch) {
          continue;
        }
        // 허용 범위 밖이면 건너 뛰기
        if (diff > defaultGap) {
          continue;
        }
        // 허용 범위 이후는 볼 필요 없음.
        if (-diff > defaultGap) {
          break;
        }

        // 같은 피치, 허용 범위 내에 존재 - 가장 가까운 값을 찾기.
        if (diff.abs() < gap) {
          matchedIdx = idx;
          gap = diff.abs();
        }
      }

      // 선택된 경우 삭제
      if (matchedIdx != -1) {
        answer.type = accType;
        answer.ts = _buffer[matchedIdx].ts - delay;
        _buffer.removeAt(matchedIdx);
        // 정답 개수 증가
        count++;
      }
    }
    accuracyCount.setByType(accType, count);
  }

  /// 배열에서 timestamp만 모아서 리스트로 리턴
  _getTimeAscList(List<MusicEntry> entries) {
    var timeList = entries.map((e) => e.ts).toSet().toList();
    timeList.sort();
    return timeList;
  }

  /// 녹음 초기에 발생한 delay에 대한 보정값 계산
  _calculateInitialDelay() {
    var musicTs = _getTimeAscList(result);
    var answerTs = _getTimeAscList(_buffer);

    double posSum = 0;
    int posCount = 0;

    double negSum = 0;
    int negCount = 0;

    for (var answer in musicTs) {
      var matchedIdx = -1;
      var gap = initBound;

      /// answer를 돌면서 현재 선택된 값
      for (var idx = 0; idx < answerTs.length; idx++) {
        var value = answerTs[idx];
        var diff = answer + delay - value;

        // 피치 안 맞거나, 허용 범위 밖이면 건너 뛰기
        if (diff > initBound) {
          continue;
        }
        // 허용 범위 이후는 볼 필요 없음.
        if (-diff > initBound) {
          break;
        }
        // 허용 범위 내에 존재 - 가장 가까운 값을 찾기.
        if (diff.abs() < gap.abs()) {
          matchedIdx = idx;
          gap = diff;
        }
      }

      // 선택된 경우 삭제
      if (matchedIdx != -1) {
        answerTs.removeAt(matchedIdx);
        if (gap.isNegative) {
          negSum += gap;
          negCount++;
        } else if (gap > 0) {
          posSum += gap;
          posCount++;
        }
      }
    }

    double avg;
    if (negCount > posCount) {
      avg = negSum / negCount;
    } else {
      avg = posSum / posCount;
    }

    return avg;
  }

  // 채점하기
  calculateWithAnswer(List<MusicEntry> musicEntries,
      {double? calculatedDelay}) async {
    initBound =
        // await ApiService.getParams('init-bound') ??
        0.3;
    minBound =
        //  await ApiService.getParams('min-bound') ??
        // 0.04;
        0.1;
    maxBound =
        // await ApiService.getParams('max-bound') ??
        // 0.1;
        0.15;
    // 채점 안된 것들 정렬
    // 시간 순으로 정렬
    musicEntries.sort((a, b) => a.ts.compareTo(b.ts));
    _buffer.sort((a, b) => a.ts.compareTo(b.ts));
    result =
        musicEntries.map((e) => ScoredEntry.fromMusicEntry(e, bpm)).toList();

    if (calculatedDelay == null) {
      // HACK: 이 부분 로직을 유지해야 할지 모르겠음.
      delay -= _calculateInitialDelay();
    } else {
      delay = calculatedDelay;
    }

    // 우선 박자 / 피치 모두 맞는 경우만 채점.
    _classify(AccuracyType.correct);
    // 피치는 일치하나 박자가 틀린 경우 채점.
    _classify(AccuracyType.wrongTiming);
    // 피치가 틀리더라도, 박자는 허용 범위 이내
    _classify(AccuracyType.wrongComponent);
    // 나머지는 놓친 음
    accuracyCount.miss =
        result.where((e) => e.type == AccuracyType.miss).length;

    // 아직 버퍼에 남아있으면 그냥 틀린 음
    accuracyCount.wrong = _buffer.length;
    result.addAll(_buffer.map((e) => ScoredEntry(
          key: e.key,
          pitch: e.pitch,
          ts: e.ts - delay,
          absTS: -1,
          type: AccuracyType.wrong,
        )));

    // 점수 설정
    _setScore();
    _setComponentCount();
  }
}
