// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_count_convertor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComponentCount _$ComponentCountFromJson(Map<String, dynamic> json) =>
    ComponentCount(
      hihat: json['hihat'] as int? ?? 0,
      smallTom: json['smallTom'] as int? ?? 0,
      snareDrum: json['snareDrum'] as int? ?? 0,
      kick: json['kick'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );

Map<String, dynamic> _$ComponentCountToJson(ComponentCount instance) =>
    <String, dynamic>{
      'hihat': instance.hihat,
      'smallTom': instance.smallTom,
      'snareDrum': instance.snareDrum,
      'kick': instance.kick,
      'total': instance.total,
    };
