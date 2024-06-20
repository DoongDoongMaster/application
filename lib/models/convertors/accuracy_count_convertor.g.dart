// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accuracy_count_convertor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccuracyCount _$AccuracyCountFromJson(Map<String, dynamic> json) =>
    AccuracyCount(
      correct: json['correct'] as int? ?? 0,
      wrongComponent: json['wrongComponent'] as int? ?? 0,
      wrongTiming: json['wrongTiming'] as int? ?? 0,
      wrong: json['wrong'] as int? ?? 0,
      miss: json['miss'] as int? ?? 0,
    );

Map<String, dynamic> _$AccuracyCountToJson(AccuracyCount instance) =>
    <String, dynamic>{
      'correct': instance.correct,
      'wrongComponent': instance.wrongComponent,
      'wrongTiming': instance.wrongTiming,
      'wrong': instance.wrong,
      'miss': instance.miss,
    };
