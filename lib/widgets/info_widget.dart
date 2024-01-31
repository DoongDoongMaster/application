import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

class DoubleInfoWidget extends StatelessWidget {
  final int originalBPM;
  final int? currentBPM;
  final double? currentSpeed;
  const DoubleInfoWidget({
    super.key,
    required this.originalBPM,
    this.currentBPM,
    this.currentSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return InfoBoard(
      child: Row(
        children: [
          InfoText(label: '원곡 BPM', currentText: originalBPM.toString()),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              thickness: 0.5,
              color: ColorStyles.miss,
            ),
          ),
          if (currentBPM != null)
            InfoText(label: '현재 BPM', currentText: currentBPM.toString()),
          if (currentSpeed != null)
            InfoText(
              label: '현재 속도',
              currentText: currentSpeed!.toStringAsFixed(2),
              unitText: ' x',
            ),
        ],
      ),
    );
  }
}

class SingleInfoWidget extends StatelessWidget {
  const SingleInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InfoBoard(
      child: const InfoText(
        label: '반복',
        currentText: '1',
        overallText: ' /2',
        unitText: ' 번',
      ),
    );
  }
}

class InfoBoard extends Container {
  InfoBoard({
    Key? key,
    Widget? child,
    Decoration? decoration,
    EdgeInsetsGeometry padding = const EdgeInsets.all(12),
  }) : super(
          key: key,
          child: child,
          decoration: decoration ??
              BoxDecoration(
                color: ColorStyles.blackShadow16,
                borderRadius: BorderRadius.circular(8),
              ),
          padding: padding,
        );
}

class InfoText extends StatelessWidget {
  final String label;
  final String? currentText, overallText, unitText;

  const InfoText({
    super.key,
    required this.label,
    this.currentText,
    this.overallText,
    this.unitText,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 50, minWidth: 63),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style:
                TextStyles.bodysmall.copyWith(color: ColorStyles.whiteShadow80),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentText != null)
                Text(
                  currentText!,
                  style: TextStyles.titleLarge.copyWith(
                    color: ColorStyles.whiteShadow80,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              if (overallText != null)
                Text(
                  overallText!,
                  style: TextStyles.bodyLarge.copyWith(
                    color: ColorStyles.whiteShadow80,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              if (unitText != null)
                Text(
                  unitText!,
                  style: TextStyles.bodyLarge
                      .copyWith(color: ColorStyles.darkGray),
                ),
            ],
          )
        ],
      ),
    );
  }
}
