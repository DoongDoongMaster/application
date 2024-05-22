import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/convertors/music_entry_convertor.dart';
import 'package:application/models/entity/drill_info.dart';
import 'package:application/services/crop_image.dart';
import 'package:drift/drift.dart';
import 'package:application/models/entity/default_table.dart';

enum MusicType {
  ddm, // 서버 제공
  user,
  // shared, // 공유된 악보 (현재 미사용)
}

class MusicInfo extends DefaultEntity {
  static const double imageWidth = 1024;
  static const double cropPaddingTop = 120;
  static const double cropPaddingBottom = 30;

  final String title, artist;
  final int bpm, measureCount, hitCount;
  final List<Cursor> cursorList, measureList;
  final Uint8List? sheetImage, xmlData;
  final MusicType type;
  final ComponentCount? sourceCount;
  final List<MusicEntry> musicEntries;

  ComponentCount get sourceCnt => ComponentCount.fromMusicEntries(musicEntries);
  int get measureCnt => measureList.length;

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

  copyWith({
    String id = "",
    String? title,
    String? artist,
    int? bpm,
    List<Cursor>? cursorList,
    List<Cursor>? measureList,
    Uint8List? sheetImage,
    List<MusicEntry>? musicEntries,
  }) =>
      MusicInfo(
        id: id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        bpm: bpm ?? this.bpm,
        sheetImage: sheetImage ?? this.sheetImage,
        xmlData: xmlData,
        cursorList: cursorList ?? this.cursorList,
        measureList: measureList ?? this.measureList,
        sourceCount: sourceCount,
        musicEntries: musicEntries ?? this.musicEntries,
        hitCount: hitCount,
      );

  MusicInfo extractDrillPart(DrillInfo drill) {
    var startHeight = max(measureList[drill.start].y - cropPaddingTop, 0.0);
    var startTs = measureList[drill.start].ts;
    var endTs = measureList[drill.end].ts;

    // 구간에 맞게 커서 및 마디 정보 자르기
    var newMeasureList = List<Cursor>.from(measureList
        .sublist(drill.start, drill.end + 1)
        .map((e) => e.copyWith(y: e.y - startHeight, ts: e.ts - startTs)));

    var newCursorList = List<Cursor>.from(cursorList
        .where((e) => e.ts >= startTs && e.ts.floor() <= endTs)
        .map((e) => e.copyWith(y: e.y - startHeight, ts: e.ts - startTs)));

    var newMusicEntries = List<MusicEntry>.from(musicEntries
        .where((e) => e.ts >= startTs && e.ts.floor() <= endTs)
        .map((e) => e.copyWith(ts: e.ts - startTs)));

    // // 악보 이미지 자르기
    // var height =
    //     newMeasureList.last.y + newMeasureList.last.h + cropPaddingBottom;

    // // 다음 줄이 있는 경우 한줄 더 늘리기
    // if (measureList.last.y + measureList.last.h - startHeight > height) {
    //   height = min(height + cropPaddingTop,
    //       measureList.last.y + measureList.last.h - startHeight);
    // }

    var croppedImage = cropImage(
      sheetImage!,
      rect: Rect.fromLTWH(
        0,
        startHeight,
        MusicInfo.imageWidth,
        0,
      ),
      scale: 2,
    );

    // 새로운 객체 반납
    return copyWith(
      id: id,
      sheetImage: croppedImage,
      measureList: newMeasureList,
      cursorList: newCursorList,
      musicEntries: newMusicEntries,
    );
  }
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
