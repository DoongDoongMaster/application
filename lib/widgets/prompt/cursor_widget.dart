import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/screens/prompt_screen.dart';
import 'package:application/styles/color_styles.dart';
import 'package:flutter/material.dart';

class CursorWidget extends StatelessWidget {
  final Cursor cursorInfo;

  const CursorWidget({super.key, required this.cursorInfo});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: cursorInfo.x,
      top: cursorInfo.y + PromptScreen.sheetPadding,
      child: Container(
        decoration: BoxDecoration(
            color: ColorStyles.primaryShadow36,
            borderRadius: BorderRadius.circular(4)),
        height: cursorInfo.h,
        width: cursorInfo.w,
      ),
    );
  }
}
