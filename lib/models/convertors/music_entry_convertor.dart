import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'music_entry_convertor.g.dart';

@JsonSerializable()
class MusicEntry implements Comparable<MusicEntry> {
  final int pitch;
  double ts;
  final int? key;

  MusicEntry({
    required this.pitch,
    required this.ts,
    this.key,
  });

  MusicEntry.createEmpty()
      : ts = 0,
        pitch = -1,
        key = null;

  factory MusicEntry.fromJson(Map<String, dynamic> json) =>
      _$MusicEntryFromJson(json);

  Map<String, dynamic> toJson() => _$MusicEntryToJson(this);
  // @override
  // int get hashCode => pitch.hashCode;

  // @override
  // bool operator ==(Object other) {
  //   return other is MusicEntry && (pitch == other.pitch && ts == other.ts);
  // }

  @override
  int compareTo(MusicEntry other) {
    if (this == other) {
      return -1;
    } else if (ts > other.ts) {
      return 1;
    } else {
      return 0;
    }
  }
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
