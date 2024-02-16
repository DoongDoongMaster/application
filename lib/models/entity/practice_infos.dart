import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/entity/default_table.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

class PracticeInfo {
  final String id, projectId, title;
  final int? bpm;
  final double? speed;
  final int? score;
  final bool isNew;
  final ComponentCount componentCount;
  final AccuracyCount accuracyCount;

  PracticeInfo({
    required this.id,
    required this.projectId,
    required this.title,
    this.score,
    this.bpm,
    this.speed,
    required this.isNew,
    required this.accuracyCount,
    required this.componentCount,
  });
}

@UseRowClass(PracticeInfo)
class PracticeInfos extends DefaultTable {
  TextColumn get title =>
      text().clientDefault(() => DateTime.now().toIso8601String())();

  IntColumn get score => integer().nullable()();
  IntColumn get bpm => integer().nullable()();
  RealColumn get speed => real().nullable()();
  BoolColumn get isNew => boolean().withDefault(const Constant(true))();

  TextColumn get projectId =>
      text().references(ProjectInfos, #id, onDelete: KeyAction.cascade)();

  IntColumn get correctCnt => integer().nullable()();
  IntColumn get wrongComponentCnt => integer().nullable()();
  IntColumn get wrongTimingCnt => integer().nullable()();
  IntColumn get wrongCnt => integer().nullable()();
  IntColumn get missCnt => integer().nullable()();

  TextColumn get componentCount =>
      text().map(const ComponentCountConvertor())();

  TextColumn get accuracyCount => text().map(const AccuracyCountConvertor())();
}
