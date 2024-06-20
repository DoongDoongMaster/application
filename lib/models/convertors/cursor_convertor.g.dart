// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursor_convertor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cursor _$CursorFromJson(Map<String, dynamic> json) => Cursor(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      w: (json['w'] as num).toDouble(),
      h: (json['h'] as num).toDouble(),
      ts: (json['ts'] as num).toDouble(),
    );

Map<String, dynamic> _$CursorToJson(Cursor instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'w': instance.w,
      'h': instance.h,
      'ts': instance.ts,
    };
