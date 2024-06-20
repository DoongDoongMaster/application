import 'dart:math';

import 'package:application/main.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/entity/default_report_info.dart';
import 'package:application/models/entity/drill_report_info.dart';
import 'package:application/models/views/project_summary_view.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/custom_dialog.dart';
import 'package:application/widgets/project/analysis_summary.dart';
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
  final String? drillId;
  final PromptOption promptOption;
  final ComponentCount? sourceCnt;
  final int? hitCnt;
  const PromptSettingModal({
    super.key,
    required this.promptOption,
    this.sourceCnt,
    this.hitCnt,
    this.drillId,
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

  void _updateBPM(int value) {
    if (value < 0 || value > 200) {
      return;
    }
    setState(() {
      widget.promptOption.currentBPM = value;
      widget.promptOption.speed = value / widget.promptOption.originalBPM;
    });
  }

  void _updateCount(int value) {
    if (value < 0) {
      return;
    }
    setState(() {
      widget.promptOption.count = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      width: (widget.promptOption.type == ReportType.drill) ? 700 : 540,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          if (widget.promptOption.type == ReportType.drill)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: FutureBuilder<List<DrillReportInfo>>(
                future: database.getPreviosDrillRecord(widget.drillId!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  }

                  snapshot.data!.map((e) => e.transcription).toList();
                  if (snapshot.data!.isEmpty ||
                      snapshot.data![0].scores == null) {
                    return const Text("레포트가 비어 있음");
                  } else {
                    var report = snapshot.data![0];
                    var idx = 0;
                    var bestScore = 0;
                    for (var i = 0; i < report.count; i++) {
                      if (report.scores![i] > bestScore) {
                        bestScore = report.scores![i];
                        idx = i;
                      }
                    }

                    var data = AnalysisSummaryData.fromDrillReport(
                      bestIdx: idx,
                      sourceCnt: widget.sourceCnt!,
                      // hitCount: widget.hitCnt,
                      scores: report.scores!,
                      accuracyList: report.accuracyCounts,
                    );
                    return AnalysisSummary(
                      data: data,
                      previewSize: min(10, report.count),
                    );
                  }
                },
                // builder: (context) => const SizedBox(),
              ),
            ),
          const Divider(height: 0),
          Container(
            decoration: const BoxDecoration(color: ColorStyles.background),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.promptOption.type == ReportType.full) ...[
                  const _GuideText(text: "속도를 설정할 수 있습니다."),
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
                ] else ...[
                  const SizedBox(height: 10),
                  const _GuideText(text: 'BPM을 설정할 수 있습니다.'),
                  ValueSettingWidget(
                    updateValue: _updateBPM,
                    value: widget.promptOption.currentBPM,
                    originalValue: widget.promptOption.originalBPM,
                    text: "BPM",
                    maxValue: 200,
                  ),
                  const _GuideText(text: '반복 횟수를 설정할 수 있습니다.'),
                  ValueSettingWidget(
                    updateValue: _updateCount,
                    value: widget.promptOption.count,
                    originalValue: 3,
                    text: "번",
                    maxValue: 10,
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
          Container(),
          const Divider(height: 0),
          StartButton(
              onPressed: () => Navigator.pop(context, widget.promptOption))
        ],
      ),
    );
  }
}

class ValueSettingWidget extends StatelessWidget {
  final String text;
  final void Function(int value) updateValue;
  final int value, originalValue;
  final int minValue, maxValue;

  const ValueSettingWidget({
    super.key,
    required this.value,
    required this.originalValue,
    required this.updateValue,
    required this.text,
    this.minValue = 1,
    required this.maxValue,
  });

  int _floorToTen(int value) {
    var r = value % 10;
    if (r == 0) {
      value -= 10;
    } else {
      value -= r;
    }
    return value;
  }

  int _ceilToTen(int value) {
    value += 10 - value % 10;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Spacer(flex: 1),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AddSubButton(
                  icon: Icons.remove_rounded,
                  onTap: value > minValue ? () => updateValue(value - 1) : null,
                  onLongPress: value > minValue
                      ? () => updateValue(_floorToTen(value))
                      : null,
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 50,
                  child: Text(
                    " $value",
                    style: TextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      decorationColor: ColorStyles.darkGray,
                      decoration: TextDecoration.combine(
                        [TextDecoration.underline],
                      ),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                    width: 50,
                    child: Text("  $text", style: TextStyles.bodyMedium)),
                const SizedBox(width: 8),
                AddSubButton(
                  icon: Icons.add_rounded,
                  onTap: value < maxValue ? () => updateValue(value + 1) : null,
                  onLongPress: value < maxValue
                      ? () => updateValue(_ceilToTen(value))
                      : null,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: (value != originalValue)
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: ResetButton(
                          onPressed: () => updateValue(originalValue)))
                  : null,
            ),
          )
        ],
      ),
    );
  }
}

class _GuideText extends StatelessWidget {
  final String text;
  const _GuideText({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        text,
        style: TextStyles.bodyMedium
            .copyWith(color: ColorStyles.onSurfaceBlackVariant),
      ),
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

class AddSubButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap, onLongPress;

  const AddSubButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorStyles.lighterGray,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: SizedBox.square(
          dimension: 40,
          child: Icon(
            icon,
            size: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
