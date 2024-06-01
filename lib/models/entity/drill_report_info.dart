import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/scored_entry_convertor.dart';
import 'package:application/models/entity/default_report_info.dart';
import 'package:application/models/entity/drill_info.dart';
import 'package:application/models/entity/list_convertor.dart';
import 'package:drift/drift.dart';

class DrillReportInfo extends DefaultReportInfo {
  final String drillId;
  final int count;
  final List<int>? scores;
  List<List<ScoredEntry>>? results;
  List<ComponentCount> get componentCounts =>
      results?.map((e) => ComponentCount.fromScoredEntries(e)).toList() ?? [];
  List<AccuracyCount> get accuracyCounts =>
      results?.map((e) => AccuracyCount.fromScoredEntries(e)).toList() ?? [];

  DrillReportInfo({
    super.id = "",
    super.createdAt,
    super.updatedAt,
    super.title,
    super.bpm,
    super.transcription,
    super.isNew,
    this.results,
    this.scores,
    this.drillId = "",
    this.count = 1,
  }) : super();
}

@UseRowClass(DrillReportInfo)
class DrillReportInfos extends DefalutReportInfos {
  TextColumn get drillId =>
      text().references(DrillInfos, #id, onDelete: KeyAction.restrict)();

  IntColumn get count => integer().withDefault(const Constant(1))();

  TextColumn get scores => text().map(const ListConverter<int>()).nullable()();
  TextColumn get results => text()
      .map(const ScoredEntry2dListConvertor())
      .withDefault(Constant(const ScoredEntry2dListConvertor().toSql([])))
      .nullable()();
}
