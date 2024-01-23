import 'package:application/styles/color_styles.dart';
import 'package:flutter/material.dart';

class ShadowStyles {
  static const dropShadow = BoxShadow(
    offset: Offset(0, 2),
    blurRadius: 6,
    spreadRadius: 0,
    color: ColorStyles.blackShadow36,
  );
  static const shadow200 = BoxShadow(
    offset: Offset(0, -2),
    blurRadius: 16,
    spreadRadius: 0,
    color: ColorStyles.blackShadow8,
    // color: Colors.red,
  );

  static const shadow300 = BoxShadow(
    offset: Offset(0, 2),
    blurRadius: 8,
    spreadRadius: 0,
    color: ColorStyles.blackShadow36,
  );

  static const button200 = BoxShadow(
    offset: Offset(0, 2),
    blurRadius: 8,
    spreadRadius: 0,
    color: ColorStyles.blackShadow24,
  );

  static const dropShadowSmall = BoxShadow(
    offset: Offset(0, 2),
    blurRadius: 4,
    spreadRadius: 0,
    color: ColorStyles.blackShadow16,
  );
}
// 2, 4, 16
