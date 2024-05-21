import 'package:application/styles/color_styles.dart';
import 'package:application/widgets/positioned_container.dart';
import 'package:flutter/material.dart';

class CursorWidget extends PositionedContainer {
  CursorWidget({super.key, required super.cursor})
      : super(
          decoration: BoxDecoration(
            color: ColorStyles.primaryShadow36,
            borderRadius: BorderRadius.circular(4),
          ),
        );
}
