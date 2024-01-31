import 'dart:math';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

class RestartButtonWithProgressIndicator extends StatelessWidget {
  static const double circleSize = 130;
  static const double footerHeight = 105;
  static const double indicatorStrokeWidth = 22;
  static double offsetInRadian = acos(footerHeight / circleSize);
  static double offsetRatio = offsetInRadian / (2 * pi);

  final int lengthInSec;

  final void Function() onPressed;

  const RestartButtonWithProgressIndicator({
    super.key,
    required this.lengthInSec,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 0,
          width: circleSize + 2 * indicatorStrokeWidth,
          child: OverflowBox(
            maxHeight: 200,
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: pi,
              origin: const Offset(0, footerHeight / 2),
              child: Transform.translate(
                offset: const Offset(0, footerHeight / 2),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: const [ShadowStyles.shadow300],
                  ),
                  width: circleSize + 2 * indicatorStrokeWidth,
                  height: circleSize + 2 * indicatorStrokeWidth,
                  child: lengthInSec == 0
                      ? const MusicProgressIndicator(
                          indicatorStrokeWidth: indicatorStrokeWidth)
                      : TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                              begin: offsetRatio, end: 1 - offsetRatio),
                          duration: Duration(seconds: lengthInSec),
                          builder: (context, value, _) {
                            return CircularProgressIndicator(
                              value: value,
                              strokeWidth: indicatorStrokeWidth,
                              color: ColorStyles.primary,
                              backgroundColor: ColorStyles.progressBackground,
                              semanticsLabel: 'music progress bar',
                              strokeAlign: -1,
                            );
                          },
                        ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: footerHeight,
          width: circleSize,
          child: OverflowBox(
            maxHeight: 200,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                boxShadow: const [ShadowStyles.shadow300],
              ),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyles.secondary,
                  shadowColor: ColorStyles.blackShadow36,
                  foregroundColor: Colors.black,
                  shape: const CircleBorder(),
                  fixedSize: const Size(circleSize, circleSize),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.replay_rounded,
                      size: 64,
                      color: Colors.white,
                    ),
                    Text(
                      "다시 시작",
                      style: TextStyles.bodysmall.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MusicProgressIndicator extends StatelessWidget {
  const MusicProgressIndicator({
    super.key,
    required this.indicatorStrokeWidth,
  });

  final double indicatorStrokeWidth;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: 0,
      strokeWidth: indicatorStrokeWidth,
      color: ColorStyles.primary,
      backgroundColor: ColorStyles.progressBackground,
      semanticsLabel: 'music progress bar',
      strokeAlign: -1,
    );
  }
}
