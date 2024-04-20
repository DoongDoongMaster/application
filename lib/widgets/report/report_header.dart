import 'dart:math';

import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/report/disc_shape_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportHeader extends StatelessWidget {
  static const double visibleWidth = 292;
  static const Size panelSize = Size(360, 200);
  final PracticeReportViewData report;

  const ReportHeader(this.report, {super.key});

  @override
  Widget build(BuildContext context) {
    double spaceUnit = (MediaQuery.of(context).size.width -
            panelSize.width * 2 -
            visibleWidth) /
        5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DiscShapeWidget(
          width: visibleWidth,
          title: report.musicTitle!,
          artist: report.musicArtist!,
          score: report.score!,
          sourceBPM: report.sourceBPM!,
          bpm: report.bpm,
          speed: report.speed,
        ),
        SizedBox(width: spaceUnit * 2),
        _ResultCard(
          label: "정확도 분석",
          size: panelSize,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: _AccuracyAnalysisChart(
                  accuracyData: report.accuracyCount!,
                  score: report.score!,
                  bestScore: report.bestScore!,
                ),
              ),
              const Spacer(),
              AccuracyAnalysisChartLegend(
                accuracyCnt: report.accuracyCount!,
                autoSizeGroup: AutoSizeGroup(),
                hitCount: report.hitCount,
              ),
              const Spacer(),
              const SizedBox(width: 15),
            ],
          ),
        ),
        SizedBox(width: spaceUnit + 3),
        _ResultCard(
          label: "음정 분석",
          size: panelSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...DrumComponent.values
                  .sublist(0, DrumComponent.values.length - 1)
                  .map(
                    (data) => _AnalysisPerComponent(
                      label: data.label,
                      hitCnt: report.componentCount!.getByType(data),
                      sourceCnt: report.sourceCount.getByType(data),
                    ),
                  ),
            ],
          ),
        ),
        SizedBox(width: spaceUnit * 2 - 3),
      ],
    );
  }
}

class _AnalysisPerComponent extends StatelessWidget {
  static const double circleSize = 70;
  final String label;
  final int hitCnt, sourceCnt;

  const _AnalysisPerComponent({
    required this.label,
    required this.hitCnt,
    required this.sourceCnt,
  });

  @override
  Widget build(BuildContext context) {
    late double score;
    if (sourceCnt > 0) {
      score = hitCnt / sourceCnt;
    } else {
      score = 0;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                offset: const Offset(0, 1),
                color: Colors.transparent.withOpacity(0.25),
              )
            ],
          ),
          child: Transform.rotate(
            angle: -pi / 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(circleSize),
              clipBehavior: Clip.hardEdge,
              child: TweenAnimationBuilder(
                curve: Curves.bounceOut,
                tween: Tween<double>(begin: 0, end: score),
                duration: Duration(milliseconds: (1500 * score).toInt()),
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    color: ColorStyles.primary.withOpacity(0.9),
                    backgroundColor: (sourceCnt == 0
                            ? ColorStyles.secondary
                            : ColorStyles.primary)
                        .withOpacity(0.2),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(
          width: 0,
          height: 0,
          child: OverflowBox(
            maxHeight: circleSize,
            minHeight: circleSize,
            maxWidth: circleSize,
            minWidth: circleSize,
            child: SizedBox(
              width: circleSize / 2,
              height: circleSize / 2,
              child: Transform.translate(
                offset: const Offset(0, -circleSize / 2),
                child: Align(
                  alignment: Alignment.center,
                  child: AutoSizeText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${sourceCnt == 0 ? '-' : (100 * score).toInt()}',
                          style: TextStyles.headlineSmall
                              .copyWith(color: Colors.white),
                        ),
                        TextSpan(
                          text: '%',
                          style: TextStyles.bodysmall.copyWith(
                            color: const Color(0xFF974F00),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: sourceCnt == 0 ? '-' : "$hitCnt"),
              TextSpan(
                text: "/${sourceCnt == 0 ? '-' : sourceCnt}\n",
                style: const TextStyle(
                  color: ColorStyles.graphMiss,
                ),
              ),
              TextSpan(
                text: label,
                style: TextStyles.bodyMedium,
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyles.bodysmall.copyWith(height: 1.5),
        )
      ],
    );
  }
}

class AccuracyAnalysisChartLegend extends StatelessWidget {
  static const double width = 130;
  const AccuracyAnalysisChartLegend({
    super.key,
    required this.accuracyCnt,
    required this.autoSizeGroup,
    this.hitCount,
  });
  final int? hitCount;
  final AccuracyCount? accuracyCnt;
  final AutoSizeGroup autoSizeGroup;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 항목 라벨
          ...AccuracyType.values.map(
            (data) => Row(
              // alignment: WrapAlignment.spaceBetween,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.rotate(
                      angle: data.shouldRotate ? pi / 4 : 0,
                      child: Icon(
                        data.icon,
                        color: data.color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 3, height: 25),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: (width - 23) * 0.7,
                        maxHeight: 25,
                      ),
                      child: AutoSizeText(
                        data.label,
                        style: const TextStyle(color: ColorStyles.graphLegend),
                        minFontSize: 1,
                        maxFontSize: TextStyles.bodyMedium.fontSize!,
                        maxLines: 1,
                        group: autoSizeGroup,
                      ),
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: (width - 23) * 0.7,
                    maxHeight: 25,
                  ),
                  child: AutoSizeText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${accuracyCnt?.getByType(data) ?? '-'}",
                          style: TextStyle(
                              fontWeight: data == AccuracyType.correct
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                        if (data == AccuracyType.correct)
                          TextSpan(
                            text: "/${hitCount ?? "-"}",
                            style:
                                const TextStyle(color: ColorStyles.graphMiss),
                          ),
                      ],
                    ),
                    group: autoSizeGroup,
                    minFontSize: 1,
                    maxFontSize: TextStyles.bodyLarge.fontSize!,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 정확도 도넛 차트
class _AccuracyAnalysisChart extends StatelessWidget {
  /// 차트 크기 관련 설정 값
  static const double chartSize = 150;
  static const double graphThickness = 12; // 그래프 두께.
  static const double strokeWidth = 2;
  static const double innerPaddingValue = 0; // 그래프 라이브러리 자체에서 생성되는 것 같음. 추정치.

  final AccuracyCount accuracyData;
  final int score, bestScore;

  const _AccuracyAnalysisChart({
    required this.accuracyData,
    required this.score,
    required this.bestScore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: chartSize + 2 * innerPaddingValue,
          height: chartSize + 2 * innerPaddingValue,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                // 바깥 그림자
                color: Colors.transparent.withOpacity(0.25),
                blurRadius: 1,
                spreadRadius: -(innerPaddingValue - 1),
                offset: const Offset(0, 1),
                blurStyle: BlurStyle.outer,
              ),
              const BoxShadow(
                // 안쪽 색 어두워지는거 방지
                color: Colors.white,
                spreadRadius: -innerPaddingValue,
                blurStyle: BlurStyle.solid,
              ),
              BoxShadow(
                // 안쪽 그림자
                color: Colors.transparent.withOpacity(0.25),
                spreadRadius: -(innerPaddingValue + graphThickness),
                blurStyle: BlurStyle.solid,
              ),
              const BoxShadow(
                // 안쪽 색 어두워지는거 방지
                color: ColorStyles.panelCard,
                blurRadius: 1,
                spreadRadius: -(innerPaddingValue + graphThickness + 1),
                offset: Offset(0, 1),
                blurStyle: BlurStyle.solid,
              ),
            ],
          ),
          child: PieChart(
            PieChartData(
              centerSpaceRadius: chartSize / 2 - graphThickness + strokeWidth,
              startDegreeOffset: -90,
              sections: [
                for (var data in AccuracyType.values)
                  PieChartSectionData(
                    value: accuracyData.getByType(data)!.toDouble(),
                    showTitle: false,
                    color: data.color.withOpacity(0.7),
                    radius: graphThickness - 2 * strokeWidth,
                  )
              ],
            ),
            swapAnimationDuration:
                const Duration(milliseconds: 1000), // Optional
            swapAnimationCurve: Curves.linear, // Optional
          ),
        ),
        SizedBox(
          width: chartSize,
          height: 0,
          child: OverflowBox(
            minHeight: chartSize,
            maxHeight: chartSize,
            alignment: Alignment.center,
            child: Transform.translate(
              offset: const Offset(0, -chartSize / 2),
              child: _OverAllScoreInfo(
                score: score,
                bestScore: bestScore,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _OverAllScoreInfo extends StatelessWidget {
  final int score;
  final int bestScore;
  const _OverAllScoreInfo({
    required this.score,
    required this.bestScore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 55,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AutoSizeText.rich(
              TextSpan(
                style: const TextStyle(letterSpacing: 1.25, height: 1.25),
                children: [
                  TextSpan(
                    text: "$score",
                    style: TextStyles.displayMedium.copyWith(
                      color: ColorStyles.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "점",
                    style: TextStyles.titleLarge.copyWith(
                      color: ColorStyles.secondaryShadow90,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 35,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AutoSizeText.rich(
              TextSpan(
                style: TextStyle(
                  height: 1,
                  fontSize: TextStyles.bodyMedium.fontSize,
                ),
                children: [
                  const TextSpan(
                    text: "최고 점수\n",
                    style: TextStyle(
                      color: ColorStyles.secondaryShadow90,
                    ),
                  ),
                  TextSpan(
                    text: "$bestScore",
                    style: const TextStyle(
                      color: ColorStyles.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: "점",
                    style: TextStyle(
                      color: ColorStyles.secondaryShadow90,
                    ),
                  ),
                ],
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String label;
  final Widget? child;
  final Size size;
  const _ResultCard({
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
