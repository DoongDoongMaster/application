import 'dart:convert';

import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/convertors/music_entry_convertor.dart';
import 'package:drift/drift.dart';
import 'package:application/models/entity/default_table.dart';

enum MusicType {
  ddm, // 서버 제공
  user,
  // shared, // 공유된 악보 (현재 미사용)
}

class MusicInfo extends DefaultEntity {
  final String title, artist;
  final int bpm, measureCount, hitCount;
  final List<Cursor> cursorList;
  final Uint8List? sheetImage;
  final Uint8List? xmlData;
  final List<Cursor> measureList;
  final MusicType type;
  final ComponentCount? sourceCount;
  final List<MusicEntry> musicEntries;

  MusicInfo({
    super.id = "",
    super.createdAt,
    super.updatedAt,
    this.title = "",
    this.artist = "",
    this.bpm = 90,
    this.hitCount = 0,
    this.cursorList = const [],
    this.measureList = const [],
    this.type = MusicType.user,
    this.sheetImage,
    this.xmlData,
    this.sourceCount,
    this.musicEntries = const [],
  })  : measureCount = measureList.length,
        super();

  factory MusicInfo.fromJson(
      {required String title,
      required Map<String, dynamic> json,
      required String base64String,
      required xmlData}) {
    var componentCount = ComponentCount();
    componentCount.setWithAdtKey(json["sourceCount"]);
    var cursorList =
        List<Cursor>.from(json["cursorList"].map((v) => Cursor.fromJson(v)));
    var musicEntries = List<MusicEntry>.from(
        json["musicEntries"].map((v) => MusicEntry.fromJson(v)));

    return MusicInfo(
      title: title,
      cursorList: cursorList,
      hitCount: musicEntries.where((e) => e.pitch != -1).length,
      measureList:
          List<Cursor>.from(json["measureList"].map((v) => Cursor.fromJson(v))),
      sheetImage: base64Decode(base64String),
      type: MusicType.user,
      sourceCount: componentCount,
      xmlData: xmlData,
      musicEntries: musicEntries,
    );
  }

  copyWith({String? title, String? artist, int? bpm}) => MusicInfo(
        title: title ?? this.title,
        artist: artist ?? this.artist,
        bpm: bpm ?? this.bpm,
        sheetImage: sheetImage,
        xmlData: xmlData,
        cursorList: cursorList,
        measureList: measureList,
        sourceCount: sourceCount,
        musicEntries: musicEntries,
        hitCount: hitCount,
      );
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
  BlobColumn get sheetImage => blob().clientDefault(() => Uint8List(0))();

  BlobColumn get xmlData => blob().clientDefault(() => Uint8List(0))();
  IntColumn get type => intEnum<MusicType>().clientDefault(() => 0)();

  TextColumn get sourceCount =>
      text().map(const ComponentCountConvertor()).withDefault(
          Constant(const ComponentCountConvertor().toSql(ComponentCount())))();
  TextColumn get musicEntries => text()
      .map(const MusicEntryListConvertor())
      .withDefault(Constant(const MusicEntryListConvertor().toSql([])))();
  IntColumn get hitCount => integer().withDefault(const Constant(0))();
}
