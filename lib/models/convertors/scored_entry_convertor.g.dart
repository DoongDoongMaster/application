// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scored_entry_convertor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoredEntry _$ScoredEntryFromJson(Map<String, dynamic> json) => ScoredEntry(
      key: json['key'] as int?,
      pitch: json['pitch'] as int,
      ts: (json['ts'] as num).toDouble(),
      absTS: (json['absTS'] as num).toDouble(),
      type: $enumDecode(_$AccuracyTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$ScoredEntryToJson(ScoredEntry instance) =>
    <String, dynamic>{
      'pitch': instance.pitch,
      'ts': instance.ts,
      'key': instance.key,
      'absTS': instance.absTS,
      'type': _$AccuracyTypeEnumMap[instance.type]!,
    };

const _$AccuracyTypeEnumMap = {
  AccuracyType.correct: 'correct',
  AccuracyType.wrongComponent: 'wrongComponent',
  AccuracyType.wrongTiming: 'wrongTiming',
  AccuracyType.wrong: 'wrong',
  AccuracyType.miss: 'miss',
};
