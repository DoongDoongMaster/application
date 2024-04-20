import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/music_entry_convertor.dart';
import 'package:application/models/convertors/scored_entry_convertor.dart';
import 'package:application/models/entity/default_table.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

class PracticeInfo extends DefaultEntity {
  final String projectId, title;
  final int? bpm;
  final double? speed;
  final int? score;
  final bool isNew;
  ComponentCount? componentCount;
  AccuracyCount? accuracyCount;
  List<MusicEntry>? transcription;
  List<ScoredEntry>? result;

  PracticeInfo({
    super.id = "",
    super.createdAt,
    super.updatedAt,
    this.projectId = "",
    this.title = "",
    this.score,
    this.bpm,
    this.speed,
    this.isNew = false,
    this.accuracyCount,
    this.componentCount,
    this.transcription = const [],
    this.result = const [],
  }) : super();
}

@UseRowClass(PracticeInfo)
class PracticeInfos extends DefaultTable {
  TextColumn get title => text().clientDefault(() => DateTime.now()
      .toString()
      .replaceAll(RegExp(r':\d\d\.\d+'), '')
      .replaceAll('-', '.'))();

  IntColumn get score => integer().nullable()();
  IntColumn get bpm => integer().nullable()();
  RealColumn get speed => real().nullable()();
  BoolColumn get isNew => boolean().withDefault(const Constant(false))();

  TextColumn get projectId =>
      text().references(ProjectInfos, #id, onDelete: KeyAction.restrict)();

  TextColumn get componentCount =>
      text().map(const ComponentCountConvertor()).nullable()();

  TextColumn get accuracyCount =>
      text().map(const AccuracyCountConvertor()).nullable()();

  TextColumn get transcription => text()
      .map(const MusicEntryListConvertor())
      .withDefault(Constant(const MusicEntryListConvertor().toSql([])))();
  TextColumn get result => text()
      .map(const ScoredEntryListConvertor())
      .withDefault(Constant(const ScoredEntryListConvertor().toSql([])))
      .nullable()();
}
