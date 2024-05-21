import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'cursor_convertor.g.dart';

@JsonSerializable()
class Cursor {
  final double x;
  final double y;
  final double w;
  final double h;
  final double ts;

  Cursor({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.ts,
  });

  Cursor.createEmpty()
      : x = 0,
        y = 0,
        w = 0,
        h = 0,
        ts = 0;

  copyWith({double? x, double? y, double? w, double? h, double? ts}) => Cursor(
        x: x ?? this.x,
        y: y ?? this.y,
        w: w ?? this.w,
        h: h ?? this.h,
        ts: ts ?? this.ts,
      );

  factory Cursor.fromJson(Map<String, dynamic> json) => _$CursorFromJson(json);

  Map<String, dynamic> toJson() => _$CursorToJson(this);
}

class CursorListConvertor extends TypeConverter<List<Cursor>, String> {
  const CursorListConvertor();
  @override
  List<Cursor> fromSql(String fromDb) {
    return List<Cursor>.from((json.decode(fromDb) as List<dynamic>)
        .map((v) => Cursor.fromJson(v))
        .toList());
  }

  @override
  String toSql(List<Cursor> value) {
    return json.encode(value.map((v) => v.toJson()).toList());
  }
}
