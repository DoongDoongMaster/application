import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/styles/color_styles.dart';
import 'package:flutter/material.dart';

class PositionedContainer extends Positioned {
  PositionedContainer({
    super.key,
    required Cursor cursor,
    BoxDecoration? decoration,
    Widget? child,
    double? height,
  }) : super(
          left: cursor.x,
          top: cursor.y + cursor.h - (height ?? cursor.h),
          child: Container(
            height: height ?? cursor.h,
            width: cursor.w,
            decoration: decoration,
            child: child,
          ),
        );
}

class PositionedInkWell extends PositionedContainer {
  PositionedInkWell({
    super.key,
    required super.cursor,
    super.decoration,
    super.height,
    void Function()? onTap,
  }) : super(
          child: Material(
            child: InkWell(
              highlightColor: ColorStyles.primaryShadow36,
              onTap: onTap,
            ),
          ),
        );
}
