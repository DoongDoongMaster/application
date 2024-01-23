import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PromptControlButton extends StatelessWidget {
  final Icon icon;
  final String buttonLabel;
  final void Function() onPressed;

  const PromptControlButton({
    super.key,
    required this.icon,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [ShadowStyles.button200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: ColorStyles.blackShadow24,
          backgroundColor: ColorStyles.buttonBlack,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(12),
          minimumSize: const Size(72, 70),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              buttonLabel,
              style: TextStyles.bodysmall.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
