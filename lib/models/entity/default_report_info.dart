import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/music_entry_convertor.dart';
import 'package:application/models/convertors/scored_entry_convertor.dart';
import 'package:application/models/entity/default_table.dart';
import 'package:drift/drift.dart';

class DefaultReportInfo extends DefaultEntity {
  final String title;
  final int bpm;
  final int? score;
  final bool isNew;
  ComponentCount? componentCount;
  AccuracyCount? accuracyCount;
  List<MusicEntry>? transcription;
  List<ScoredEntry>? result;

  DefaultReportInfo({
    super.id = "",
    super.createdAt,
    super.updatedAt,
    this.title = "",
    this.score,
    this.bpm = 90,
    this.isNew = false,
    this.componentCount,
    this.accuracyCount,
    this.transcription = const [],
    this.result = const [],
  }) : super();
}

@UseRowClass(DefaultReportInfo)
class DefalutReportInfos extends DefaultTable {
  TextColumn get title => text().clientDefault(() => DateTime.now()
      .toString()
      .replaceAll(RegExp(r':\d\d\.\d+'), '')
      .replaceAll('-', '.'))();

  IntColumn get score => integer().nullable()();
  IntColumn get bpm => integer()();
  BoolColumn get isNew => boolean().withDefault(const Constant(false))();

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
