import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// 기본 테이블, id, created_at, updated_at 존재.
// @TableIndex(name: 'default_table', columns: {#id, #createdAt})
class DefaultEntity {
  final String id;
  DateTime createdAt, updatedAt;
  DefaultEntity({
    required this.id,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}

@UseRowClass(DefaultEntity)
class DefaultTable extends Table {
  TextColumn get id => text().unique().clientDefault(() => const Uuid().v4())();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
