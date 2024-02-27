import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/time_utils.dart';
import 'package:drift/drift.dart';
import 'package:application/models/entity/default_table.dart';

enum MusicType {
  ddm, // 서버 제공
  user,
  // shared, // 공유된 악보 (현재 미사용)
}

class MusicInfo {
  final String id, title, artist;
  final int bpm, measureCount;
  final List<Cursors> cursorList;
  final Uint8List? sheetSvg;
  final List<Cursors> measureList;
  final MusicType type;
  final ComponentCount sourceCount;

  MusicInfo({
    this.id = "",
    this.title = "",
    this.artist = "",
    this.bpm = 90,
    this.cursorList = const [],
    this.measureList = const [],
    this.type = MusicType.user,
    this.sheetSvg,
    this.sourceCount = const {},
  }) : measureCount = measureList.length;
}

@UseRowClass(MusicInfo)
class MusicInfos extends DefaultTable {
  /// 1. 곡 정보, 악보 사진 등 저장 필요함. => 앱 내 저장공간 활용한 후 경로 작성. (근데 이 방식은 무결성 유지가 안될 수가 있음/물론 밖에서 삭제는 안되지만 그래도.)
  /// 2. blob 형태로 저장 -  일단 이걸로 해봅시다. [v]
  /// 3. S3 bucket [x]
  /// 4. firebase 저장소

  TextColumn get title => text().withDefault(const Constant("이름 없는 악보"))();
  IntColumn get bpm => integer().withDefault(const Constant(90))();
  IntColumn get measureCount => integer().withDefault(const Constant(0))();
  TextColumn get artist => text().withDefault(const Constant("이름 없는 아티스트"))();

  // BlobColumn get infoJson => blob()();
  TextColumn get cursorList => text()
      .map(const CursorListConvertor())
      .withDefault(Constant(const CursorListConvertor().toSql([])))();
  TextColumn get measureList => text()
      .map(const CursorListConvertor())
      .withDefault(Constant(const CursorListConvertor().toSql([])))();
  BlobColumn get sheetSvg => blob().clientDefault(() => Uint8List(0))();
  IntColumn get type => intEnum<MusicType>().clientDefault(() => 0)();

  TextColumn get sourceCount => text()
      .map(const ComponentCountConvertor())
      .withDefault(Constant(const ComponentCountConvertor().toSql({})))();
}
