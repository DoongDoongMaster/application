class MusicModel {
  final List<CursorModel> cursorList;
  late final List<MeasureModel> measureList;

  final int bpm;
  final String title;
  final String artist;

  MusicModel.fromJson(
    Map<String, dynamic> json, {
    required this.title,
    required this.artist,
    required this.bpm,
  })  : cursorList = json["cursorList"]
            .map<CursorModel>((value) => CursorModel.fromJson(value))
            .toList(),
        measureList = json["measureList"]
            .map<MeasureModel>((value) => MeasureModel.fromJson(value))
            .toList();
}

// TODO: 마디 인덱스, 시작 위치, 끝 위치, 높이, 너비 등
class MeasureModel {
  // cursorIdx[start: end)
  final int? startCursorIdx = 0;
  final int? endCursorIdx = 0;

// timestamp [start:end)
  final double top;
  final double left;
  final double width;
  final double height;
  final double timestamp;

  MeasureModel.fromJson(Map<String, dynamic> json)
      : left = json["left"].toDouble(),
        top = json["top"].toDouble(),
        width = json["width"].toDouble(),
        height = json["height"].toDouble(),
        timestamp = json["timestamp"].toDouble();
}

class CursorModel {
  final double top;
  final double left;
  final double width;
  final double height;
  final double timestamp;

  CursorModel()
      : top = 0,
        left = 0,
        width = 0,
        height = 0,
        timestamp = 0;

  CursorModel.fromJson(Map<String, dynamic> json)
      : left = json["left"].toDouble(),
        top = json["top"].toDouble(),
        width = json["width"].toDouble(),
        height = json["height"].toDouble(),
        timestamp = json["timestamp"].toDouble();
}
