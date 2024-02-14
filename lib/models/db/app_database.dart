import 'dart:io';

import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/practice_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:application/models/views/music_thumbnail_view.dart';
import 'package:application/models/views/project_detail_view.dart';
import 'package:application/models/views/project_sidebar_view.dart';
import 'package:application/models/views/project_thumbnail_view.dart';
import 'package:application/services/local_storage.dart';
import 'package:application/time_utils.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file =
        File(p.join(await LocalStorage.getLocalPath(), 'ddm_db.sqlite'));

    if (!await file.exists()) {
      // Extract the pre-populated database file from assets
      // final blob = await rootBundle.load('assets/srn_db_2.sqlite');
      // final buffer = blob.buffer;
      // await file.writeAsBytes(
      //     buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes));
      print("not exists");
    }
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [
  MusicInfos,
  ProjectInfos,
  PracticeInfos,
], views: [
  MusicThumbnailView,
  ProjectDetailView,
  ProjectSidebarView,
  ProjectThumbnailView,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          if (true) {
            final m = Migrator(this);
            for (final table in allTables) {
              await m.deleteTable(table.actualTableName);
              await m.createTable(table);
            }
            await m.recreateAllViews();
          }
        },
      );

  @override
  int get schemaVersion => 1;

  Future resetDatabse() {
    return transaction(() async {
      await delete(practiceInfos).go();
      await delete(projectInfos).go();
      await delete(musicInfos).go();
    });
  }

  Future<List<MusicThumbnailViewData>> getTopMusicsByType(
      MusicType type, int count) {
    return (select(musicThumbnailView)
          ..where((tbl) => tbl.type.equalsValue(type))
          ..limit(count))
        .get();
  }

  Future<int> toggleProjectLike(String projectId) async {
    final result = await customWriteReturning(
      'UPDATE project_infos SET is_liked = 1 - is_liked WHERE id = ? RETURNING is_liked',
      variables: [Variable(projectId)],
      updateKind: UpdateKind.update,
      updates: {projectInfos},
    );

    if (result.length != 1) {
      throw Exception('no such project');
    }

    return result[0].data["is_liked"];
  }

  Future<void> addNewProject(String title, String musicId) => into(projectInfos)
      .insert(ProjectInfosCompanion.insert(title: title, musicId: musicId));

  Future<void> addNewMusic(MusicInfo music) =>
      into(musicInfos).insert(MusicInfosCompanion.insert(
        title: music.title,
        bpm: music.bpm,
        artist: music.artist,
        cursorList: [],
        measureList: [],
        sheetSvg: music.sheetSvg,
        type: music.type,
        lengthInSec: TimeUtils.getTotalDurationInSec(music.bpm, 0),
      ));

  Future<void> deleteProject(String id) =>
      (delete(projectInfos)..where((tbl) => tbl.id.equals(id))).go();
}
