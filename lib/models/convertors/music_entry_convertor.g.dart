// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_entry_convertor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicEntry _$MusicEntryFromJson(Map<String, dynamic> json) => MusicEntry(
      pitch: json['pitch'] as int,
      ts: (json['ts'] as num).toDouble(),
      key: json['key'] as int?,
    );

Map<String, dynamic> _$MusicEntryToJson(MusicEntry instance) =>
    <String, dynamic>{
      'pitch': instance.pitch,
      'ts': instance.ts,
      'key': instance.key,
    };
