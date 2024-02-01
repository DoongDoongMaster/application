import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewButton extends StatelessWidget {
  final String label;
  final Size size;
  final void Function() onPressed;
  const AddNewButton(
      {super.key,
      required this.label,
      required this.size,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize: size,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: DottedBorder(
          color: ColorStyles.primary,
          strokeWidth: 1,
          stackFit: StackFit.expand,
          borderType: BorderType.RRect,
          radius: const Radius.circular(8),
          borderPadding: const EdgeInsets.all(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_rounded, size: 36),
              const SizedBox(height: 7),
              Text(label, style: TextStyles.bodyMedium)
            ],
          ),
        ));
  }
}
