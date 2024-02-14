import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// 기본 테이블, id, created_at, updated_at 존재.
// @TableIndex(name: 'default_table', columns: {#id, #createdAt})
class DefaultTable extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
