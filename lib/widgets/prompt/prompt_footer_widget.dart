import 'dart:math';

import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PromptFooterWidget extends StatelessWidget {
  final int originalBPM;
  final int? currentBPM;
  final double? currentSpeed;
  final int lengthInSec;
  final int currentSec;

  final bool isMuted;

  final void Function() onPressMute;
  final void Function()? onPressRestart;
  final void Function()? onPressCancel;

  const PromptFooterWidget({
    super.key,
    required this.originalBPM,
    this.currentBPM,
    this.currentSpeed,
    required this.isMuted,
    required this.onPressMute,
    required this.lengthInSec,
    required this.currentSec,
    required this.onPressRestart,
    required this.onPressCancel,
  });

  secToString(int sec) {
    if (sec < 0) sec = 0;

    var min = sec ~/ 60;
    sec -= min * 60;

    return '$min:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: ColorStyles.secondary),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 105,
      child: UnconstrainedBox(
        constrainedAxis: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  _PromptControlButton(
                    buttonLabel: "메트로놈",
                    icon: Icon(
                      isMuted
                          ? Icons.volume_off_rounded
                          : Icons.volume_up_rounded,
                      color: Colors.white,
                    ),
                    onPressed: onPressMute,
                  ),
                  const SizedBox(width: 16),
                  _DoubleInfoWidget(
                    originalBPM: originalBPM,
                    currentBPM: currentBPM,
                    currentSpeed: currentSpeed,
                  )
                ],
              ),
            ),
            RestartButtonWithProgressIndicator(
              lengthInSec: currentSec == 0 ? 0 : lengthInSec,
              onPressed: onPressRestart,
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: 30),
                  Text(
                    "${secToString(currentSec)} / ${secToString(lengthInSec)}",
                    style: TextStyles.bodysmall.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.25,
                    ),
                  ),
                  const Spacer(),
                  _PromptControlButton(
                    buttonLabel: "취소하기",
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.red,
                    ),
                    onPressed: onPressCancel,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestartButtonWithProgressIndicator extends StatelessWidget {
  static const double circleSize = 130;
  static const double footerHeight = 105;
  static const double indicatorStrokeWidth = 22;
  static double offsetInRadian = acos(footerHeight / circleSize);
  static double offsetRatio = offsetInRadian / (2 * pi);

  final int lengthInSec;

  final void Function()? onPressed;

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
                      ? const _MusicProgressIndicator(
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
                  disabledBackgroundColor: ColorStyles.onSurfaceBlack,
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

class _MusicProgressIndicator extends StatelessWidget {
  const _MusicProgressIndicator({
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

class _DoubleInfoWidget extends StatelessWidget {
  final int originalBPM;
  final int? currentBPM;
  final double? currentSpeed;
  const _DoubleInfoWidget({
    required this.originalBPM,
    this.currentBPM,
    this.currentSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return _InfoBoard(
      child: Row(
        children: [
          _InfoText(label: '원곡 BPM', currentText: originalBPM.toString()),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              thickness: 0.5,
              color: ColorStyles.graphMiss,
            ),
          ),
          if (currentBPM != null)
            _InfoText(label: '현재 BPM', currentText: currentBPM.toString()),
          if (currentSpeed != null)
            _InfoText(
              label: '현재 속도',
              currentText: currentSpeed!.toStringAsFixed(2),
              unitText: ' x',
            ),
        ],
      ),
    );
  }
}

class _SingleInfoWidget extends StatelessWidget {
  const _SingleInfoWidget();

  @override
  Widget build(BuildContext context) {
    return _InfoBoard(
      child: const _InfoText(
        label: '반복',
        currentText: '1',
        overallText: ' /2',
        unitText: ' 번',
      ),
    );
  }
}

class _InfoBoard extends Container {
  _InfoBoard({
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

class _InfoText extends StatelessWidget {
  final String label;
  final String? currentText, overallText, unitText;

  const _InfoText({
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

class _PromptControlButton extends StatelessWidget {
  final Icon icon;
  final String buttonLabel;
  final void Function()? onPressed;

  const _PromptControlButton({
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
