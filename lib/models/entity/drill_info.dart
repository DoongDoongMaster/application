import 'package:application/models/entity/default_table.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

class DrillInfo extends DefaultEntity {
  final String projectId;
  final int start, end;

  DrillInfo({
    super.id = "",
    super.createdAt,
    super.updatedAt,
    this.projectId = "",
    this.start = -1,
    this.end = -1,
  }) : super();
}

@UseRowClass(DrillInfo)
class DrillInfos extends DefaultTable {
  TextColumn get projectId =>
      text().references(ProjectInfos, #id, onDelete: KeyAction.restrict)();
  IntColumn get start => integer()();
  IntColumn get end => integer()();
}
