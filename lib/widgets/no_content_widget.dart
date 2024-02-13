import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

class NoContentWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const NoContentWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.sentiment_neutral_rounded,
          size: 56,
          color: ColorStyles.primary.withOpacity(0.64),
        ),
        const SizedBox(height: 20),
        Text(title, style: TextStyles.bodyLarge),
        const SizedBox(height: 18),
        Text(subTitle,
            style:
                TextStyles.bodysmall.copyWith(color: const Color(0xFF919191))),
      ],
    );
  }
}
