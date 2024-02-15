import 'dart:math';

import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/report/disc_shape_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportScreen extends StatelessWidget {
  static const double headerHeight = 312;
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: context.canPop()
          ? TextButton(
              onPressed: () {}, // TODO: 다시 시작 버튼 로직 구현
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1C1C25),
                shadowColor: ShadowStyles.shadow300.color,
                elevation: 8,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.replay_rounded, size: 24),
                  SizedBox(width: 4),
                  Text("다시 시작"),
                ],
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: headerHeight,
            color: ColorStyles.background,
            child: const _Header(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - headerHeight,
            child: OverflowBox(
              maxHeight: MediaQuery.of(context).size.height,
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: headerHeight),
                    Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [ShadowStyles.shadow200]),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/music/stay-with-me.svg',
                              width: 1024,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  static const double spaceUnit = 20;

  static const Size panelSize = Size(360, 200);

  const _Header();

  @override
  Widget build(BuildContext context) {
    double visibleWidth =
        MediaQuery.of(context).size.width - panelSize.width * 2 - spaceUnit * 5;
    final AccuracyResult pieChartData = {
      GradeType.correct: 186,
      GradeType.wrongComponent: 56,
      GradeType.wrongTiming: 48,
      GradeType.wrong: 20,
      GradeType.miss: 16,
    };
    const int totalCount = 250;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DiscShapeWidget(
          width: visibleWidth,
        ),
        const SizedBox(width: spaceUnit * 2),
        _ScorePanel(
          label: "정확도 분석",
          child: Row(
            children: [
              AccuracyDoughnutChart(pieChartData: pieChartData),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: AccuracyDoughnutChartLegend(
                    pieChartData: pieChartData,
                    totalCount: totalCount,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: spaceUnit + 3),
        const _ScorePanel(
          label: "음정 분석",
        ),
        const SizedBox(width: spaceUnit * 2 - 3),
      ],
    );
  }
}

class AccuracyDoughnutChartLegend extends StatelessWidget {
  const AccuracyDoughnutChartLegend({
    super.key,
    required this.pieChartData,
    required this.totalCount,
  });

  final AccuracyResult pieChartData;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 항목 라벨
        ...GradeType.values.map(
          (data) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
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
                        size: 24,
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
                      "${pieChartData[data]}",
                      style: TextStyles.bodyLarge,
                    ),
                    if (data == GradeType.correct)
                      Text(
                        "/$totalCount",
                        style: TextStyles.bodyLarge
                            .copyWith(color: ColorStyles.graphMiss),
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

/// 정확도 파이차트 (도넛 차트)
class AccuracyDoughnutChart extends StatelessWidget {
  /// 차트 크기 관련 설정 값
  static const double chartSize = 160;
  static const double graphThickness = 12; // 그래프 두께.
  static const double strokeWidth = 2;

  static const double innerRadiusRatio =
      100 - graphThickness * 2 / chartSize * 100; // 0 ~ 100으로 설정. 클 수록 얇은 그래프.
  static const double innerPaddingValue = 20; // 그래프 라이브러리 자체에서 생성되는 것 같음. 추정치.

  const AccuracyDoughnutChart({
    super.key,
    required this.pieChartData,
  });

  final AccuracyResult pieChartData;

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
        annotations: const <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: _OverAllScoreInfo(currentScore: 96, highestScore: 100),
          ),
        ],
        series: <CircularSeries>[
          DoughnutSeries<GradeType, String>(
            dataSource: GradeType.values,
            xValueMapper: (GradeType data, _) => data.label,
            yValueMapper: (GradeType data, _) => pieChartData[data],
            pointColorMapper: (GradeType data, _) =>
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
  final int currentScore;
  final int highestScore;
  const _OverAllScoreInfo({
    required this.currentScore,
    required this.highestScore,
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
                    text: "$currentScore",
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
                    text: "$highestScore",
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

enum GradeType {
  correct(
    label: '정답',
    color: ColorStyles.graphCorrect,
    icon: Icons.check_circle_outline_rounded,
  ),
  wrongComponent(
    label: '음정 오답',
    color: ColorStyles.graphWrongComponent,
    icon: Icons.error_outline_rounded,
  ),
  wrongTiming(
    label: '박자 오답',
    color: ColorStyles.graphWrongTiming,
    icon: Icons.error_outline_rounded,
  ),
  wrong(
    label: '오답',
    color: ColorStyles.graphWrong,
    icon: Icons.add_circle_outline_rounded,
    shouldRotate: true,
  ),
  miss(
    label: 'miss',
    color: ColorStyles.graphMiss,
    icon: Icons.add_circle_outline_rounded,
    shouldRotate: true,
  );

  const GradeType({
    required this.label,
    required this.color,
    required this.icon,
    this.shouldRotate = false,
  });

  final String label;
  final Color color;
  final IconData icon;
  final bool shouldRotate;
}

typedef AccuracyResult = Map<GradeType, int>;

class _ScorePanel extends StatelessWidget {
  final String label;
  final Widget? child;
  const _ScorePanel({
    required this.label,
    this.child,
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
          size: _Header.panelSize,
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
