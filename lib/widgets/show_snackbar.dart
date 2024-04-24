import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

/// text를 보여주는 스낵바
showSnackbar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 400,
        right: 400,
      ),
      content:
          Text(text, style: TextStyles.bodyMedium, textAlign: TextAlign.center),
      backgroundColor: ColorStyles.blackShadow80,
      duration: const Duration(seconds: 3),
    ),
  );
}
