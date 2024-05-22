import 'package:application/models/entity/default_report_info.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/custom_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class PromptOption {
  double speed = 1;
  int originalBPM, currentBPM;
  int count;
  ReportType type;

  PromptOption({required this.type, int bpm = 90, int count = 3})
      : originalBPM = bpm,
        currentBPM = bpm,
        count = (type == ReportType.drill) ? count : 0;
}

class PromptSettingModal extends StatefulWidget {
  final PromptOption promptOption;
  const PromptSettingModal({
    super.key,
    required this.promptOption,
  });

  @override
  State<PromptSettingModal> createState() => PromptSettingModalState();
}

class PromptSettingModalState extends State<PromptSettingModal> {
  static const _initialValue = 2;
  static const List<double> speed = [0.5, 0.75, 1.0, 1.25, 1.5];
  int _value = _initialValue;

  String get title => widget.promptOption.type == ReportType.full
      ? "완곡 연주를 시작하기 전에"
      : "구간 반복 연습장";

  void changeSpeed(int idx) {
    setState(() {
      widget.promptOption.speed = speed[idx];
      widget.promptOption.currentBPM =
          (widget.promptOption.originalBPM * speed[idx]).toInt();
      _value = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      height: widget.promptOption.type == ReportType.full ? 240 : 500,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context, null);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: ColorStyles.primary,
                          size: 16,
                        ),
                        label: Text(
                          '나가기',
                          style: TextStyles.bodysmall
                              .copyWith(color: ColorStyles.primary),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          foregroundColor: ColorStyles.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyles.bodyMedium
                        .copyWith(color: ColorStyles.onSurfaceBlack),
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
          const Divider(height: 0),
          Container(
            height: 96,
            decoration: const BoxDecoration(color: ColorStyles.background),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _GuideText(text: "속도를 설정할 수 있습니다."),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (_value != 2) const SizedBox(width: 32),
                    Wrap(
                      spacing: 5.0,
                      children: [
                        ...speed.mapIndexed(
                          (index, value) => SpeedChoiceChip(
                            selected: _value == index,
                            speed: value,
                            onSelected: (selected) => setState(() {
                              if (selected) {
                                changeSpeed(index);
                              }
                            }),
                          ),
                        )
                      ],
                    ),
                    if (_value != 2)
                      ResetButton(
                        onPressed: () => changeSpeed(_initialValue),
                      )
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          StartButton(
              onPressed: () => Navigator.pop(context, widget.promptOption))
        ],
      ),
    );
  }
}

class _GuideText extends StatelessWidget {
  final String text;
  const _GuideText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.bodysmall
          .copyWith(color: ColorStyles.onSurfaceBlackVariant),
    );
  }
}

class SpeedChoiceChip extends StatelessWidget {
  const SpeedChoiceChip({
    super.key,
    required this.selected,
    required this.speed,
    this.onSelected,
  });
  final void Function(bool)? onSelected;
  final bool selected;
  final double speed;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      labelStyle: TextStyles.bodysmall
          .copyWith(color: selected ? Colors.white : Colors.black),
      backgroundColor: ColorStyles.lightGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      label: Text('${speed}x'),
      selected: selected,
      onSelected: onSelected,
    );
  }
}

class StartButton extends StatelessWidget {
  final void Function() onPressed;

  const StartButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.play_circle_fill_rounded,
          size: 64,
          color: ColorStyles.primary,
          shadows: [ShadowStyles.dropShadowSmall],
        ),
      ),
    );
  }
}

class ResetButton extends StatelessWidget {
  final void Function() onPressed;
  const ResetButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        icon: const Icon(
          Icons.history_rounded,
          size: 16,
          color: ColorStyles.secondary,
        ),
        onPressed: onPressed,
        style: IconButton.styleFrom(backgroundColor: ColorStyles.lightGray),
      ),
    );
  }
}
