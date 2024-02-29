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
  final ComponentCount? componentCount;
  final AccuracyCount? accuracyCount;

  PracticeInfo({
    this.id = "",
    this.projectId = "",
    this.title = "",
    this.score,
    this.bpm,
    this.speed,
    this.isNew = false,
    this.accuracyCount = const {},
    this.componentCount = const {},
  });
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
      text().references(ProjectInfos, #id, onDelete: KeyAction.cascade)();

  TextColumn get componentCount =>
      text().map(const ComponentCountConvertor()).nullable()();

  TextColumn get accuracyCount =>
      text().map(const AccuracyCountConvertor()).nullable()();
}
