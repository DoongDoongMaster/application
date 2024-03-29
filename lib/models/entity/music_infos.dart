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

class MusicInfo {
  final String id, title, artist;
  final int bpm, measureCount;
  final List<Cursors> cursorList;
  final Uint8List? sheetImage;
  final List<Cursors> measureList;
  final MusicType type;
  final ComponentCount sourceCount;
  final List<MusicEntry> musicEntries;

  MusicInfo({
    this.id = "",
    this.title = "",
    this.artist = "",
    this.bpm = 90,
    this.cursorList = const [],
    this.measureList = const [],
    this.type = MusicType.user,
    this.sheetImage,
    this.sourceCount = const {},
    this.musicEntries = const [],
  }) : measureCount = measureList.length;

  factory MusicInfo.fromJson(
      {required String title,
      required Map<String, dynamic> json,
      required String base64String}) {
    return MusicInfo(
      title: title,
      cursorList: List<Cursors>.from(
          json["cursorList"].map((v) => Cursors.fromJson(v))),
      measureList: List<Cursors>.from(
          json["measureList"].map((v) => Cursors.fromJson(v))),
      sheetImage: base64Decode(base64String.split(',')[1]),
      type: MusicType.user,
      sourceCount: {
        for (var v in DrumComponent.values)
          v.name: json["sourceCount"][v.adtKey.toString()]!,
      },
      musicEntries: List<MusicEntry>.from(
          json["musicEntries"].map((v) => MusicEntry.fromJson(v))),
    );
  }

  copyWith({String? title, String? artist, int? bpm}) => MusicInfo(
        title: title ?? this.title,
        artist: artist ?? this.artist,
        bpm: bpm ?? this.bpm,
        sheetImage: sheetImage,
        cursorList: cursorList,
        measureList: measureList,
        sourceCount: sourceCount,
        musicEntries: musicEntries,
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
  IntColumn get type => intEnum<MusicType>().clientDefault(() => 0)();

  TextColumn get sourceCount => text()
      .map(const ComponentCountConvertor())
      .withDefault(Constant(const ComponentCountConvertor().toSql({})))();
  TextColumn get musicEntries => text()
      .map(const MusicEntryListConvertor())
      .withDefault(Constant(const MusicEntryListConvertor().toSql([])))();
}
