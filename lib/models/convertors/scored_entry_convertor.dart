import 'dart:convert';

import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/music_entry_convertor.dart';
import 'package:application/time_utils.dart';
import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scored_entry_convertor.g.dart';

@JsonSerializable()
class ScoredEntry extends MusicEntry {
  double absTS;
  AccuracyType type = AccuracyType.miss; // 매칭 안된 음으로 초기화

  ScoredEntry({
    required super.key,
    required super.pitch,
    required super.ts, // 음이 매칭된 경우 실제 초 (offset 계산 안 한 raw value)
    required this.absTS, // 이건 마디를 기준으로 한 timestamp 1.0 (두번째 마디 시작하자마자 첫 음)
    required this.type,
  });

  ScoredEntry.createEmpty()
      : absTS = 0,
        super.createEmpty();

  ScoredEntry.fromMusicEntry(MusicEntry musicEntry, int bpm,
      {this.type = AccuracyType.miss})
      : absTS = musicEntry.ts,
        super(
          pitch: musicEntry.pitch,
          ts: musicEntry.ts * TimeUtils.getSecPerBeat(bpm) * 4,
          key: musicEntry.key,
        );

  factory ScoredEntry.fromJson(Map<String, dynamic> json) =>
      _$ScoredEntryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScoredEntryToJson(this);
}

class ScoredEntryListConvertor
    extends TypeConverter<List<ScoredEntry>, String> {
  const ScoredEntryListConvertor();
  @override
  List<ScoredEntry> fromSql(String fromDb) {
    return List<ScoredEntry>.from((json.decode(fromDb) as List<dynamic>)
        .map((v) => ScoredEntry.fromJson(v))
        .toList());
  }

  @override
  String toSql(List<ScoredEntry> value) {
    return json.encode(value.map((v) => v.toJson()).toList());
  }
}

class ScoredEntry2dListConvertor
    extends TypeConverter<List<List<ScoredEntry>>, String> {
  const ScoredEntry2dListConvertor();
  @override
  List<List<ScoredEntry>> fromSql(String fromDb) {
    return List<List<ScoredEntry>>.from((json.decode(fromDb) as List<dynamic>)
        .map((v) => const ScoredEntryListConvertor().fromSql(v))
        .toList());
  }

  @override
  String toSql(List<List<ScoredEntry>> value) {
    return json.encode(
        value.map((v) => const ScoredEntryListConvertor().toSql(v)).toList());
  }
}
