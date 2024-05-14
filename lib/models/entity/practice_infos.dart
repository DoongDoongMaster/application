import 'package:application/models/entity/project_infos.dart';
import 'package:application/models/entity/default_report_info.dart';
import 'package:drift/drift.dart';

class PracticeInfo extends DefaultReportInfo {
  final String projectId;
  final double speed;

  PracticeInfo({
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
    this.projectId = "",
    this.speed = 1,
  }) : super();
}

@UseRowClass(PracticeInfo)
class PracticeInfos extends DefalutReportInfos {
  TextColumn get projectId =>
      text().references(ProjectInfos, #id, onDelete: KeyAction.restrict)();
  RealColumn get speed => real().withDefault(const Constant(1))();
}
