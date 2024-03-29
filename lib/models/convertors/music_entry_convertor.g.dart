// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_entry_convertor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicEntry _$MusicEntryFromJson(Map<String, dynamic> json) => MusicEntry(
      pitch: (json['pitch'] as List<dynamic>).map((e) => e as int).toList(),
      ts: (json['ts'] as num).toDouble(),
    );

Map<String, dynamic> _$MusicEntryToJson(MusicEntry instance) =>
    <String, dynamic>{
      'pitch': instance.pitch,
      'ts': instance.ts,
    };
