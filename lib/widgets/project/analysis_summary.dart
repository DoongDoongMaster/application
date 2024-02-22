import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/views/project_summary_view.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/project/panel.dart';
import 'package:application/widgets/report/report_header.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalysisSummary extends StatelessWidget {
  final AnalysisSummaryData data;
  const AnalysisSummary({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Panel(
                size: const Size(0, 200),
                child: _ScoreChart(
                  bestScore: data.bestScore!,
                  scoreList: data.scoreList,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              flex: 9,
              child: Panel(
                size: const Size(0, 200),
                child: _AccuracyChart(
                    accuracyCount: data.bestCount!,
                    accuracyList: data.accuracyList),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AccuracyChart extends StatelessWidget {
  const _AccuracyChart({
    required this.accuracyCount,
    required this.accuracyList,
  });

  final AccuracyCount accuracyCount;
  final List<AccuracyCount?> accuracyList;

  @override
  Widget build(BuildContext context) {
    final isNotReady =
        accuracyList.map((v) => v == null ? true : false).toList();

    return Row(
      children: [
        const SizedBox(width: 15),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "최고 기록",
                style: TextStyles.bodyMedium
                    .copyWith(color: ColorStyles.graphLegend),
              ),
              const SizedBox(
                height: 10,
              ),
              AccuracyAnalysisChartLegend(
                accuracyCnt: accuracyCount,
                totalCount: 250,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: _ChartContainer(
            drawVerticalLine: true,
            lineBarData: [
              for (var line in AccuracyType.values)
                LineChartBarData(
                  spots: [
                    for (var (i, v) in accuracyList.indexed)
                      FlSpot(
                        i.toDouble(),
                        v == null ? 0 : v[line.name]!.toDouble(),
                      )
                  ],
                  color: line.color,
                  dotData:
                      _DotData(isNotReady: isNotReady, showDefaultDot: false),
                )
            ],
          ),
        ),
      ],
    );
  }
}

class _ScoreChart extends StatelessWidget {
  const _ScoreChart({
    required this.bestScore,
    required this.scoreList,
  });

  final int bestScore;
  final List<double?> scoreList;

  @override
  Widget build(BuildContext context) {
    final isNotReady = scoreList.map((v) => v == null ? true : false).toList();
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 5, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "최고 점수\n",
                          style: TextStyles.bodyMedium.copyWith(
                            color: ColorStyles.graphLegend,
                          ),
                        ),
                        TextSpan(
                          text: bestScore.toString(),
                          style: TextStyles.headlineMedium.copyWith(
                            color: ColorStyles.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "점",
                          style: TextStyles.bodyMedium.copyWith(
                            color: ColorStyles.graphLegend,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.square_rounded,
                    size: 16,
                    shadows: [
                      Shadow(
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                          color: Colors.transparent.withOpacity(0.1))
                    ],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "점수",
                    style: TextStyles.bodysmall
                        .copyWith(color: ColorStyles.graphLegend),
                  )
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: _ChartContainer(
            drawVerticalLine: false,
            lineBarData: [
              LineChartBarData(
                spots: [
                  for (var (i, v) in scoreList.indexed)
                    FlSpot(i.toDouble(), v ?? 0)
                ],
                color: ColorStyles.primary,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorStyles.primary.withOpacity(0.8),
                      ColorStyles.primary.withOpacity(0.16 * 0.8),
                    ],
                  ),
                ),
                dotData: _DotData(isNotReady: isNotReady),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _DotData extends FlDotData {
  _DotData({required List<bool> isNotReady, bool showDefaultDot = true})
      : super(
          getDotPainter: (p0, p1, p2, index) {
            return isNotReady[index]
                ? FlDotCirclePainter(
                    color: ColorStyles.background,
                    radius: 3,
                    strokeColor: ColorStyles.graphMiss,
                    strokeWidth: 2,
                  )
                : FlDotCirclePainter(
                    color: ColorStyles.primary,
                    radius: showDefaultDot ? 4 : 0,
                  );
          },
        );
}

class _ChartContainer extends Container {
  static FlLine _getLine(_) => const FlLine(
        color: ColorStyles.lightGray,
        strokeWidth: 1,
      );

  static const BorderSide border = BorderSide(
    color: ColorStyles.lightGray,
    width: 1,
  );

  _ChartContainer({
    required List<LineChartBarData> lineBarData,
    required bool drawVerticalLine,
  }) : super(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
            color: ColorStyles.background,
          ),
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          margin: const EdgeInsets.all(10),
          child: LineChart(
            LineChartData(
              lineBarsData: lineBarData,
              backgroundColor: ColorStyles.background,
              minX: 0,
              minY: 0,
              maxY: drawVerticalLine ? null : 100,
              gridData: FlGridData(
                drawHorizontalLine: !drawVerticalLine,
                verticalInterval: 1,
                getDrawingVerticalLine: _getLine,
                drawVerticalLine: drawVerticalLine,
                horizontalInterval: 10,
                getDrawingHorizontalLine: _getLine,
              ),
              borderData: FlBorderData(
                border: Border.symmetric(
                  vertical: drawVerticalLine ? border : BorderSide.none,
                  horizontal: drawVerticalLine ? BorderSide.none : border,
                ),
              ),
              titlesData: const FlTitlesData(show: false),
            ),
          ),
        );
}
