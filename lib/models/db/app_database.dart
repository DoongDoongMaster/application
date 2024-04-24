import 'dart:io';

import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/convertors/music_entry_convertor.dart';
import 'package:application/models/convertors/scored_entry_convertor.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/practice_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:application/models/views/adt_request_view.dart';
import 'package:application/models/views/music_thumbnail_view.dart';
import 'package:application/models/views/practice_list_view.dart';
import 'package:application/models/views/practice_report_view.dart';
import 'package:application/models/views/project_detail_view.dart';
import 'package:application/models/views/project_sidebar_view.dart';
import 'package:application/models/views/project_summary_view.dart';
import 'package:application/models/views/project_thumbnail_view.dart';

import 'package:application/services/local_storage.dart';
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
  ProjectSummaryView,
  PracticeReportView,
  PracticeListView,
  PracticeAnalysisView,
  ADTRequestView,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          final m = Migrator(this);
          await m.recreateAllViews();
          if (false) {
            print("recreating database...");
            final m = Migrator(this);
            for (final table in allTables) {
              await m.deleteTable(table.actualTableName);
              await m.createTable(table);
            }
            await m.recreateAllViews();
          }
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.addColumn(practiceInfos, practiceInfos.result);
            await m.recreateAllViews();
          }
        },
      );

  @override
  int get schemaVersion => 2;

  Future resetDatabse() {
    return transaction(() async {
      await delete(practiceInfos).go();
      await delete(projectInfos).go();
      await delete(musicInfos).go();
    });
  }

////////////////////////////////////////////////
  /// MUSIC - CREATE
  Future<void> addNewMusic(MusicInfo music) =>
      into(musicInfos).insert(MusicInfosCompanion.insert(
        title: Value(music.title),
        bpm: Value(music.bpm),
        artist: Value(music.artist),
        type: Value(music.type),
        sheetImage: Value(music.sheetImage!),
        xmlData: Value(music.xmlData!),
        sourceCount: Value(music.sourceCount ?? ComponentCount()),
        cursorList: Value(music.cursorList),
        measureList: Value(music.measureList),
        measureCount: Value(music.measureCount),
        musicEntries: Value(music.musicEntries),
        hitCount: Value(music.hitCount),
      ));

  /// MUSIC - READ
  Future<List<MusicThumbnailViewData>> getTopMusicsByType(
      MusicType type, int count) {
    return (select(musicThumbnailView)
          ..where((tbl) => tbl.type.equalsValue(type))
          ..orderBy([(u) => OrderingTerm.desc(musicInfos.createdAt)])
          ..limit(count))
        .get();
  }

//////////////////////////////////////////////
  /// PROJECT - CREATE
  Future<void> addNewProject(String title, String musicId) => into(projectInfos)
      .insert(ProjectInfosCompanion.insert(title: title, musicId: musicId));

  /// PROJECT - UPDATE
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

  /// PROJECT - DELETE
  Future<void> deleteProject(String id) =>
      (delete(projectInfos)..where((tbl) => tbl.id.equals(id))).go();

//////////////////////////////////////////////
  /// PRACTICE - READ
  Future<void> readPracticeReport(String practiceId) =>
      (update(practiceInfos)..where((tbl) => tbl.id.equals(practiceId)))
          .write(const PracticeInfosCompanion(isNew: Value(false)));
  Future<List<PracticeListViewData>> getPracticeList(String projectId) =>
      (select(practiceListView)
            ..where((tbl) => tbl.projectId.equals(projectId))
            ..orderBy([(u) => OrderingTerm.desc(practiceInfos.createdAt)]))
          .get();

  /// PRACTICE - DELETE
  Future<void> deletePractice(String id) =>
      (delete(practiceInfos)..where((tbl) => tbl.id.equals(id))).go();

  /// PRACTICE - read data for ADT
  Future<ADTRequestViewData> getADTRequest(String id) =>
      (select(aDTRequestView)..where((tbl) => tbl.id.equals(id))).getSingle();

//////////////////////////////////////////////
  /// PROJECT&PRACTICE - READ
  Future<AnalysisSummaryData?> getAnalysisSummaryData(
      String projectId, int size) async {
    final projectInfo = await (select(projectSummaryView)
          ..where((tbl) => tbl.id.equals(projectId)))
        .getSingleOrNull();

    if (projectInfo == null) {
      return null;
    }

    final bestCount = await (select(practiceInfos)
          ..where((tbl) => tbl.projectId.equals(projectInfo.id))
          ..orderBy([
            (u) => OrderingTerm.desc(u.score),
            (u) => OrderingTerm.desc(u.createdAt)
          ])
          ..limit(1))
        .getSingleOrNull();

    final practiceList = await (select(practiceAnalysisView)
          ..where((tbl) => tbl.projectId.equals(projectId))
          ..orderBy([
            (u) =>
                OrderingTerm(expression: u.createdAt, mode: OrderingMode.desc)
          ])
          ..limit(size))
        .get();

    return AnalysisSummaryData(
      projectInfo: projectInfo,
      practiceList: practiceList,
      bestCount: bestCount?.accuracyCount,
    );
  }

  Future<PracticeReportViewData?> getPracticeReport(String practiceId) =>
      (select(practiceReportView)..where((tbl) => tbl.id.equals(practiceId)))
          .getSingleOrNull();

//////////////////////////////////////////////
}
