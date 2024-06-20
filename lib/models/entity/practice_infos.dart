import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/scored_entry_convertor.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:application/models/entity/default_report_info.dart';
import 'package:drift/drift.dart';

class PracticeInfo extends DefaultReportInfo {
  final String projectId;
  final double speed;
  ComponentCount? componentCount;
  AccuracyCount? accuracyCount;
  int? score;
  List<ScoredEntry>? result;

  ComponentCount get componentCnt =>
      ComponentCount.fromScoredEntries(result ?? []);
  AccuracyCount get accuracyCnt =>
      AccuracyCount.fromScoredEntries(result ?? []);

  PracticeInfo({
    super.id = "",
    super.createdAt,
    super.updatedAt,
    super.title,
    super.bpm,
    super.transcription,
    super.isNew,
    this.accuracyCount,
    this.componentCount,
    this.score,
    this.result = const [],
    this.projectId = "",
    this.speed = 1,
  }) : super();
}

@UseRowClass(PracticeInfo)
class PracticeInfos extends DefalutReportInfos {
  TextColumn get projectId =>
      text().references(ProjectInfos, #id, onDelete: KeyAction.restrict)();
  RealColumn get speed => real().withDefault(const Constant(1))();

  TextColumn get componentCount =>
      text().map(const ComponentCountConvertor()).nullable()();

  TextColumn get accuracyCount =>
      text().map(const AccuracyCountConvertor()).nullable()();

  IntColumn get score => integer().nullable()();
  TextColumn get result => text()
      .map(const ScoredEntryListConvertor())
      .withDefault(Constant(const ScoredEntryListConvertor().toSql([])))
      .nullable()();
}
