class PlayResultModel {
  final List<dynamic> noteList;
  final List<dynamic> rhythmList;
  final List<List<String>> namedNoteList = [];
  final List<List<List<bool>>> sheet = [];

  static const Map<int, String> codeToDrum = {
    0: 'HH',
    1: 'MT',
    6: 'FT',
    7: 'KK'
  };

  List<String> getNoteNames(List<int> note) {
    return note.map((v) => codeToDrum[v] as String).toList();
  }

  PlayResultModel.fromJson(Map<String, dynamic> json)
      : noteList = json["instrument"],
        rhythmList = json["rhythm"] {
    for (var i = 0; i < 3; i++) {
      sheet.add([]);
      for (var j = 0; j < 4; j++) {
        sheet[i].add(List.filled(16 * 3, false));
      }
    }

    for (var data in noteList) {
      namedNoteList.add(getNoteNames(data[1].cast<int>().toList()));

      // data[0]: i, j
      // timestamp[i][j]
      // i번째 마디
      // timestamp[i][j] * 16 -> 내림

      var i = data[0][0] - 1;
      if (i < 0) {
        continue;
      }
      var j = data[0][1];
      for (var target in data[1]) {
        if (i ~/ 3 >= 3) {
          break;
        }

        sheet[i ~/ 3][codeToPos(target)]
            [(i % 3) * 16 + (rhythmList[i + 1][j] * 16).floor()] = true;
      }
    }
  }
  int codeToPos(int code) {
    switch (code) {
      case 0:
        return 0;

      case 1:
        return 1;

      case 5:
        return 2;

      case 7:
        return 3;
    }
    return -1;
  }
}
