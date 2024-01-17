class MusicModel {
  final List<CursorModel> cursorList;
  late final List<MeasureModel> measureList;

  final int bpm;

  double currentTimestamp = 0;

  MusicModel.fromJson(Map<String, dynamic> json, {required this.bpm})
      : cursorList = json["cursorInfo"]
            .map<CursorModel>((value) => CursorModel.fromJson(value))
            .toList();
}

// TODO: 마디 인덱스, 시작 위치, 끝 위치, 높이, 너비 등
class MeasureModel {}

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
