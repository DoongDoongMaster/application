import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PanelCard extends StatelessWidget {
  final String label;
  final Widget? child;
  final Size size;
  const PanelCard({
    super.key,
    required this.label,
    this.child,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(flex: 2),
        Text(
          label,
          style: TextStyles.bodyLarge,
        ),
        const SizedBox(height: 10),
        SizedBox.fromSize(
          size: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: ColorStyles.panelCard.withOpacity(0.6),
            ),
            child: child,
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
