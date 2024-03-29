import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/music_entry_convertor.dart';

class ADTResultModel {
  static double timingErrorBound = 0.125;
  final List<MusicEntry> transcription;
  final AccuracyCount accuracyCount = AccuracyCount();
  final ComponentCount componentCount = ComponentCount();
  int score = 0;

  ADTResultModel({this.transcription = const []});
  ADTResultModel.fromJson(Map<String, dynamic> json)
      : transcription = List<MusicEntry>.from(
            json["result"].map((v) => MusicEntry.fromJson(v)));

  // 음정이 완전히 일치하는지 확인
  bool _comparePitches(List<int> list1, List<int> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    // 정렬된 상태로 비교해야 함
    list1.sort();
    list2.sort();

    for (var i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }
    return true;
  }

  ///분모: 전부 정답 + 박자 정답 + 음정 정답 + 오답 + miss<br>
  ///분자: 전부 정답 + 박자 정답 * **0.8** + 음정 정답 * **0.4**
  setScrore() {
    score = (100 * accuracyCount.correct +
            accuracyCount.wrongComponent * 0.8 +
            accuracyCount.wrongTiming * 0.4) ~/
        (accuracyCount.correct +
            accuracyCount.wrongComponent +
            accuracyCount.wrongTiming +
            accuracyCount.wrong +
            accuracyCount.miss);
  }

  calculateWithAnswer(List<MusicEntry> answer) {
    var sheetInfoMap = {for (var entry in answer) entry.ts: entry.pitch};

    List<MusicEntry> buffer = [];

    // 박자에 대해 채점
    for (var entry in transcription) {
      if (sheetInfoMap.containsKey(entry.ts)) {
        // 악보에 해당 박자 존재하는 경우
        var rest = 0;

        for (var p in entry.pitch) {
          // 사용자가 친 음이 악보에 존재하는지 확인
          if (sheetInfoMap[entry.ts]!.contains(p)) {
            sheetInfoMap[entry.ts]!.remove(p);
            var c = getDrumComponentFromADTKey(p);
            // 맞는 경우 해당 컴포넌트 업데이트
            componentCount.setByType(c, componentCount.getByType(c) + 1);
          } else {
            rest++;
          }
        }

        if (rest == 0 && sheetInfoMap[entry.ts]!.isEmpty) {
          // 전부 일치한 경우
          accuracyCount.correct++;
        } else {
          // 음정 오답
          accuracyCount.wrongComponent++;
        }

        // 해당 박자 삭제
        sheetInfoMap.remove(entry.ts);
      } else {
        // 박자 오류일 수 있으므로 버퍼에 추가
        buffer.add(entry);
      }
    }

    for (var entry in buffer) {
      //사용자가 친 기록 중에서
      var flag = false;
      for (var src in sheetInfoMap.entries) {
        if (entry.ts - src.key < timingErrorBound &&
            _comparePitches(entry.pitch, src.value)) {
          // 악기가 일치 & 박자 적으면
          accuracyCount.wrongTiming++;
          sheetInfoMap.remove(src.key);
          flag = true;
          break;
        }
        if (src.key - entry.ts > timingErrorBound) {
          // 그 이상은 의미 없음
          break;
        }
      }

      // 박자 오답이 아닌 경우
      if (!flag) {
        accuracyCount.wrong++;
      }
    }

    // 아직 남아 있는 것은 놓친 것
    accuracyCount.miss = sheetInfoMap.length;

    // 점수 설정
    setScrore();
  }
}
