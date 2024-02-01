import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'cursor_convertor.g.dart';

@JsonSerializable()
class Cursors {
  final double top;
  final double left;
  final double width;
  final double height;
  final double timestamp;

  Cursors({
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    required this.timestamp,
  });

  Cursors.createEmpty()
      : top = 0,
        left = 0,
        width = 0,
        height = 0,
        timestamp = 0;

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
