import 'dart:math';

import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/report/disc_shape_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
              _AccuracyAnalysisChart(
                pieChartData: report.accuracyCount,
                score: report.score!,
                bestScore: report.bestScore!,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: _AccuracyAnalysisChartLegend(
                    pieChartData: report.accuracyCount,
                    totalCount: report.sourceCount![DrumComponent.total.name]!,
                  ),
                ),
              )
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
                      hitCnt: report.componentCount[data.name],
                      sourceCnt: report.sourceCount![data.name]!,
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

class _AccuracyAnalysisChartLegend extends StatelessWidget {
  const _AccuracyAnalysisChartLegend({
    required this.pieChartData,
    required this.totalCount,
  });

  final AccuracyCount pieChartData;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 항목 라벨
        ...AccuracyType.values.map(
          (data) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.rotate(
                      angle: data.shouldRotate ? pi / 4 : 0,
                      child: Icon(
                        data.icon,
                        color: data.color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      data.label,
                      style: TextStyles.bodyMedium.copyWith(
                        color: const Color(0xFF77757A),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${pieChartData[data.name]}",
                      style: TextStyles.bodyLarge,
                    ),
                    if (data == AccuracyType.correct)
                      Text(
                        "/$totalCount",
                        style: TextStyles.bodyMedium.copyWith(
                          color: ColorStyles.graphMiss,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// 정확도 도넛 차트
class _AccuracyAnalysisChart extends StatelessWidget {
  /// 차트 크기 관련 설정 값
  static const double chartSize = 160;
  static const double graphThickness = 12; // 그래프 두께.
  static const double strokeWidth = 2;

  static const double innerRadiusRatio =
      100 - graphThickness * 2 / chartSize * 100; // 0 ~ 100으로 설정. 클 수록 얇은 그래프.
  static const double innerPaddingValue = 20; // 그래프 라이브러리 자체에서 생성되는 것 같음. 추정치.

  final AccuracyCount pieChartData;
  final int score, bestScore;

  const _AccuracyAnalysisChart({
    super.key,
    required this.pieChartData,
    required this.score,
    required this.bestScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SfCircularChart(
        margin: EdgeInsets.zero,
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: _OverAllScoreInfo(score: score, bestScore: bestScore),
          ),
        ],
        series: <CircularSeries>[
          DoughnutSeries<AccuracyType, String>(
            dataSource: AccuracyType.values,
            xValueMapper: (AccuracyType data, _) => data.label,
            yValueMapper: (AccuracyType data, _) => pieChartData[data.name],
            pointColorMapper: (AccuracyType data, _) =>
                data.color.withOpacity(0.7),
            innerRadius: '$innerRadiusRatio%',
            strokeColor: Colors.white,
            animationDuration: 1000,
            strokeWidth: strokeWidth,
          ),
        ],
      ),
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
