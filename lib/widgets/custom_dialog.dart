import 'package:flutter/material.dart';

class CustomDialog extends Dialog {
  final double? height;
  CustomDialog({Key? key, Widget? child, this.height})
      : super(
          key: key,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: 540,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x4C000000),
                  blurRadius: 3,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 10,
                  offset: Offset(0, 6),
                  spreadRadius: 4,
                )
              ],
            ),
            child: child,
          ),
        );
}
