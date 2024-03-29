import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'music_entry_convertor.g.dart';

@JsonSerializable()
class MusicEntry {
  final List<int> pitch;
  final double ts;

  MusicEntry({
    required this.pitch,
    required this.ts,
  });

  MusicEntry.createEmpty()
      : ts = 0,
        pitch = [];

  factory MusicEntry.fromJson(Map<String, dynamic> json) =>
      _$MusicEntryFromJson(json);

  Map<String, dynamic> toJson() => _$MusicEntryToJson(this);
}

class MusicEntryListConvertor extends TypeConverter<List<MusicEntry>, String> {
  const MusicEntryListConvertor();
  @override
  List<MusicEntry> fromSql(String fromDb) {
    return List<MusicEntry>.from((json.decode(fromDb) as List<dynamic>)
        .map((v) => MusicEntry.fromJson(v))
        .toList());
  }

  @override
  String toSql(List<MusicEntry> value) {
    return json.encode(value.map((v) => v.toJson()).toList());
  }
}
