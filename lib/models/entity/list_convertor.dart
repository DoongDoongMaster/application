import 'dart:convert';

import 'package:drift/drift.dart';

class ListConverter<T> extends TypeConverter<List<T>, String> {
  const ListConverter();

  @override
  List<T> fromSql(String fromDb) {
    return List<T>.from(json.decode(fromDb));
  }

  @override
  String toSql(List<T> value) {
    return json.encode(value);
  }
}
