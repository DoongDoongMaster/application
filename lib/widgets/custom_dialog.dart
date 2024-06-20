import 'package:flutter/material.dart';

class CustomDialog extends Dialog {
  CustomDialog({Key? key, Widget? child, double? height, double width = 540})
      : super(
          key: key,
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.hardEdge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
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
