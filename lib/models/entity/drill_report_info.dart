import 'package:application/models/entity/default_report_info.dart';
import 'package:application/models/entity/drill_info.dart';
import 'package:drift/drift.dart';

class DrillReportInfo extends DefaultReportInfo {
  final String drillId;
  final int count;

  DrillReportInfo({
    super.id = "",
    super.createdAt,
    super.updatedAt,
    super.title,
    super.score,
    super.bpm,
    super.accuracyCount,
    super.componentCount,
    super.transcription,
    super.result,
    super.isNew,
    this.drillId = "",
    this.count = 1,
  }) : super();
}

@UseRowClass(DrillReportInfo)
class DrillReportInfos extends DefalutReportInfos {
  TextColumn get drillId =>
      text().references(DrillInfos, #id, onDelete: KeyAction.restrict)();

  IntColumn get count => integer().withDefault(const Constant(1))();
}
