import 'package:application/models/entity/default_table.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

class PracticeInfo {
  final String id, projectId, title;
  final int bpm;
  final int? score;
  final bool isNew;

  PracticeInfo({
    required this.id,
    required this.projectId,
    required this.title,
    this.score,
    required this.bpm,
    required this.isNew,
  });
}

@UseRowClass(PracticeInfo)
class PracticeInfos extends DefaultTable {
  TextColumn get title =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  IntColumn get score => integer().nullable()();
  IntColumn get bpm => integer()();

  // BlobColumn get resultJson => blob()();
  BoolColumn get isNew => boolean().withDefault(const Constant(true))();

  TextColumn get projectId =>
      text().references(ProjectInfos, #id, onDelete: KeyAction.cascade)();
}
