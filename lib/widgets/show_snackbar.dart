import 'package:application/globals.dart';
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
        left: 350,
        right: 350,
      ),
      content:
          Text(text, style: TextStyles.bodyMedium, textAlign: TextAlign.center),
      backgroundColor: ColorStyles.blackShadow80,
      duration: const Duration(seconds: 3),
    ),
  );
}

showGlobalSnackbar(String text) => snackbarKey.currentState?.showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          left: 350,
          right: 350,
          bottom: MediaQuery.of(snackbarKey.currentContext!).size.height - 100,
        ),
        content: Text(text,
            style: TextStyles.bodyMedium, textAlign: TextAlign.center),
        backgroundColor: ColorStyles.blackShadow80,
        duration: const Duration(seconds: 3),
      ),
    );
