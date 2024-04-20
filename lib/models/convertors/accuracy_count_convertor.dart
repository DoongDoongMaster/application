import 'dart:convert';

import 'package:application/styles/color_styles.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accuracy_count_convertor.g.dart';

enum AccuracyType {
  correct(
    label: '정답',
    color: ColorStyles.graphCorrect,
    icon: Icons.check_circle_outline_rounded,
  ),
  wrongComponent(
    label: '음정 오답',
    color: ColorStyles.graphWrongComponent,
    icon: Icons.error_outline_rounded,
  ),
  wrongTiming(
    label: '박자 오답',
    color: ColorStyles.graphWrongTiming,
    icon: Icons.error_outline_rounded,
  ),
  wrong(
    label: '오답',
    color: ColorStyles.graphWrong,
    icon: Icons.add_circle_outline_rounded,
    shouldRotate: true,
  ),
  miss(
    label: 'miss',
    color: ColorStyles.graphMiss,
    icon: Icons.add_circle_outline_rounded,
    shouldRotate: true,
  );

  const AccuracyType({
    required this.label,
    required this.color,
    required this.icon,
    this.shouldRotate = false,
  });

  final String label;
  final Color color;
  final IconData icon;
  final bool shouldRotate;
}

@JsonSerializable()
class AccuracyCount {
  int correct;
  int wrongComponent;
  int wrongTiming;
  int wrong;
  int miss;

  AccuracyCount(
      {this.correct = 0,
      this.wrongComponent = 0,
      this.wrongTiming = 0,
      this.wrong = 0,
      this.miss = 0});

  factory AccuracyCount.fromJson(Map<String, dynamic> json) =>
      _$AccuracyCountFromJson(json);
  Map<String, dynamic> toJson() => _$AccuracyCountToJson(this);

  getByType(AccuracyType type) {
    switch (type) {
      case AccuracyType.correct:
        return correct;
      case AccuracyType.wrongComponent:
        return wrongComponent;
      case AccuracyType.wrongTiming:
        return wrongTiming;
      case AccuracyType.wrong:
        return wrong;
      case AccuracyType.miss:
        return miss;
    }
  }

  setByType(AccuracyType type, int value) {
    switch (type) {
      case AccuracyType.correct:
        return correct = value;
      case AccuracyType.wrongComponent:
        return wrongComponent = value;
      case AccuracyType.wrongTiming:
        return wrongTiming = value;
      case AccuracyType.wrong:
        return wrong = value;
      case AccuracyType.miss:
        return miss = value;
    }
  }
}

class AccuracyCountConvertor extends TypeConverter<AccuracyCount, String> {
  const AccuracyCountConvertor();

  @override
  AccuracyCount fromSql(String fromDb) {
    return AccuracyCount.fromJson(json.decode(fromDb));
  }

  @override
  String toSql(AccuracyCount value) {
    return json.encode(value.toJson());
  }
}
