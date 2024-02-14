// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursor_convertor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cursors _$CursorsFromJson(Map<String, dynamic> json) => Cursors(
      top: (json['top'] as num).toDouble(),
      left: (json['left'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      timestamp: (json['timestamp'] as num).toDouble(),
    );

Map<String, dynamic> _$CursorsToJson(Cursors instance) => <String, dynamic>{
      'top': instance.top,
      'left': instance.left,
      'width': instance.width,
      'height': instance.height,
      'timestamp': instance.timestamp,
    };
