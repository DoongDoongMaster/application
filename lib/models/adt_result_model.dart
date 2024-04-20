import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/music_entry_convertor.dart';
import 'package:application/models/convertors/scored_entry_convertor.dart';
import 'package:application/time_utils.dart';

class ADTResultModel {
  final List<MusicEntry> transcription;
  late final List<MusicEntry> _buffer;
  final AccuracyCount accuracyCount = AccuracyCount();
  final ComponentCount componentCount = ComponentCount();
  late final double initBound, minBound, maxBound;
  late double delay;
  late final List<ScoredEntry> result;
  List<ScoredEntry> get remainingList =>
      result.where((element) => element.type == AccuracyType.miss).toList();

  int score = 0;

  ADTResultModel({this.transcription = const []})
      : _buffer = List<MusicEntry>.from(transcription);
  ADTResultModel.fromJson(Map<String, dynamic> json)
      : transcription = List<MusicEntry>.from(
            json["result"].map((v) => MusicEntry.fromJson(v))) {
    _buffer = List<MusicEntry>.from(transcription);
  }

  ///분모: 전부 정답 + 박자 정답 + 음정 정답 + 오답 + miss<br>
  ///분자: 전부 정답 + 박자 정답 * **0.8** + 음정 정답 * **0.4**
  _setScore() {
    score = (100 *
            (accuracyCount.correct +
                accuracyCount.wrongComponent * 0.8 +
                accuracyCount.wrongTiming * 0.6)) ~/
        (accuracyCount.correct +
            accuracyCount.wrongComponent +
            accuracyCount.wrongTiming +
            // accuracyCount.wrong +
            accuracyCount.miss);
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
        answer.ts = _buffer[matchedIdx].ts;
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
  calculateWithAnswer(List<MusicEntry> musicEntries, int bpm) async {
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

    delay = TimeUtils.getSecPerBeat(bpm) * 4; //for prompt count

    result =
        musicEntries.map((e) => ScoredEntry.fromMusicEntry(e, bpm)).toList();

    // 채점 안된 것들 정렬
    // 시간 순으로 정렬
    musicEntries.sort((a, b) => a.ts.compareTo(b.ts));
    _buffer.sort((a, b) => a.ts.compareTo(b.ts));

    // HACK: 이 부분 로직을 유지해야 할지 모르겠음.
    delay -= _calculateInitialDelay();

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
          ts: e.ts,
          absTS: -1,
          type: AccuracyType.wrong,
        )));

    // 점수 설정
    _setScore();
    _setComponentCount();
  }
}