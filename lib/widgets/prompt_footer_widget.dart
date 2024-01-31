import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/info_widget.dart';
import 'package:application/widgets/prompt_control_button.dart';
import 'package:application/widgets/restart_button_with_progress_indicator.dart';
import 'package:flutter/material.dart';

class PromptFooterWidget extends StatelessWidget {
  final int originalBPM;
  final int? currentBPM;
  final double? currentSpeed;
  final int lengthInSec;
  final int currentSec;

  final bool isMuted;

  final void Function() onPressMute;

  final void Function() onPressRestart;
  final void Function() onPressCancel;

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
                  PromptControlButton(
                    buttonLabel: "메트로놈",
                    icon: Icon(
                      isMuted
                          ? Icons.volume_off_rounded
                          : Icons.volume_up_rounded,
                      color: Colors.white,
                    ),
                    onPressed: onPressMute,
                  ),
                  // const SizedBox(width: 16),
                  // const SingleInfoWidget(),
                  const SizedBox(width: 16),
                  DoubleInfoWidget(
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
                  PromptControlButton(
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
