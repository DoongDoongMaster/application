import 'package:application/models/entity/practice_infos.dart';
import 'package:drift/drift.dart';

abstract class PracticeListView extends View {
  PracticeInfos get practice;

  @override
  Query as() => select([
        practice.id,
        practice.projectId,
        practice.title,
        practice.bpm,
        practice.speed,
        practice.score,
        practice.isNew,
        practice.createdAt,
      ]).from(practice);
}
