import 'package:application/styles/color_styles.dart';
import 'package:flutter/material.dart';

class Panel extends SizedBox {
  Panel({
    super.key,
    required Widget child,
    required Size size,
  }) : super.fromSize(
          size: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorStyles.panelCard,
            ),
            child: child,
          ),
        );
}
