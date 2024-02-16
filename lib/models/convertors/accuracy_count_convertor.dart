import 'dart:convert';

import 'package:application/styles/color_styles.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

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

typedef AccuracyCount = Map<String, int>;

class AccuracyCountConvertor extends TypeConverter<AccuracyCount, String> {
  const AccuracyCountConvertor();

  @override
  AccuracyCount fromSql(String fromDb) {
    return AccuracyCount.castFrom(json.decode(fromDb));
  }

  @override
  String toSql(AccuracyCount value) {
    return json.encode(
        {for (var k in AccuracyType.values) k.name: value[k.name] ?? 0});
  }
}
