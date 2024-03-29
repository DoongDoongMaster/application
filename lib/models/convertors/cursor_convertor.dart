import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'cursor_convertor.g.dart';

@JsonSerializable()
class Cursors {
  final double x;
  final double y;
  final double w;
  final double h;
  final double ts;

  Cursors({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.ts,
  });

  Cursors.createEmpty()
      : x = 0,
        y = 0,
        w = 0,
        h = 0,
        ts = 0;

  factory Cursors.fromJson(Map<String, dynamic> json) =>
      _$CursorsFromJson(json);

  Map<String, dynamic> toJson() => _$CursorsToJson(this);
}

class CursorListConvertor extends TypeConverter<List<Cursors>, String> {
  const CursorListConvertor();
  @override
  List<Cursors> fromSql(String fromDb) {
    return List<Cursors>.from((json.decode(fromDb) as List<dynamic>)
        .map((v) => Cursors.fromJson(v))
        .toList());
  }

  @override
  String toSql(List<Cursors> value) {
    return json.encode(value.map((v) => v.toJson()).toList());
  }
}
