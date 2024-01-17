import 'package:application/models/music_model.dart';
import 'package:application/styles/color_styles.dart';
import 'package:flutter/material.dart';

class CursorWidget extends StatelessWidget {
  final CursorModel cursorInfo;

  const CursorWidget({super.key, required this.cursorInfo});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: cursorInfo.top,
      left: cursorInfo.left,
      child: Container(
        decoration: BoxDecoration(
            color: ColorStyles.primaryShadow36,
            borderRadius: BorderRadius.circular(4)),
        child: SizedBox(
          // height: 100,
          height: cursorInfo.height,
          // width: 20,
          width: cursorInfo.width,
        ),
      ),
    );
  }
}
