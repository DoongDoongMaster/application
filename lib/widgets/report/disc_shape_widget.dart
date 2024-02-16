import 'dart:math';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/one_line_text_with_marquee.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DiscShapeWidget extends StatelessWidget {
  /// 디스크 중심 이동된 정도
  static const double offsetX = 17;

  /// 큰 디스크와 작은 디스크 사이의 비율
  static const double ratio = 4.43;

  final double width;
  final double circleSize;
  final String title, artist;
  final int sourceBPM, score;
  final int? bpm;
  final double? speed;

  const DiscShapeWidget({
    super.key,
    required this.width,
    required this.title,
    required this.artist,
    required this.sourceBPM,
    required this.score,
    this.bpm,
    this.speed,
  }) : circleSize = (width + offsetX) * 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          _DiscAnchorWidget(
            size: circleSize,
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorStyles.secondary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    ShadowStyles.button400,
                  ]),
              width: circleSize,
            ),
          ),
          _SectorWidget(
            circleSize: circleSize,
            angle: 2 * pi / 8,
            color: const Color(0xE654555E),
          ),
          _SectorWidget(
            circleSize: circleSize,
            angle: 2 * pi / 30,
            color: ColorStyles.secondary,
          ),
          _DiscAnchorWidget(
            size: circleSize / ratio,
            child: Icon(
              Icons.circle,
              size: circleSize / ratio,
              color: ColorStyles.secondary,
              shadows: const [ShadowStyles.button400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: SizedBox(
                    width: 200,
                    height: 40,
                    child: OneLineTextWithMarquee(
                      title,
                      style: TextStyles.titleLarge.copyWith(
                        color: ColorStyles.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.25,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 56, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              artist,
                              style: TextStyles.bodyMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                height: 1.25,
                              ),
                            ),
                            Text(
                              "원곡 BPM $sourceBPM",
                              style: TextStyles.bodysmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            for (var i = 0; i < 5; i++)
                              _SingleRatedStar(
                                filled: i < (score ~/ 20),
                              )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              bpm == null
                                  ? "${speed!.toStringAsFixed(2)}x"
                                  : bpm.toString(),
                              style: TextStyles.bodyMedium.copyWith(
                                color: Colors.white,
                                letterSpacing: 1.25,
                              ),
                            ),
                            Text(
                              bpm == null ? " 속도" : " BPM",
                              style: TextStyles.bodysmall.copyWith(
                                color: Colors.white,
                                letterSpacing: 1.25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
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

class _SingleRatedStar extends StatelessWidget {
  static const double size = 38;
  static const double stroke = 4;
  final bool filled;
  const _SingleRatedStar({
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.star,
          size: size,
          color: Colors.white,
        ),
        Transform.translate(
          offset: const Offset(0, -(size - stroke)),
          child: Icon(
            Icons.star,
            size: size - 2 * stroke,
            color: filled ? ColorStyles.primary : ColorStyles.stroke,
            fill: 1,
            weight: 0.5,
          ),
        ),
      ],
    );
  }
}

class _SectorWidget extends StatelessWidget {
  final double circleSize;
  final Color color;
  final double angle;

  const _SectorWidget({
    required this.circleSize,
    required this.color,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      origin: _DiscAnchorWidget.defaultOffset,
      child: _DiscAnchorWidget(
        size: circleSize / 2,
        align: Alignment.bottomLeft,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(circleSize / 2),
            ),
          ),
        ),
      ),
    );
  }
}

class _DiscAnchorWidget extends SizedBox {
  static const Offset defaultOffset = Offset(-DiscShapeWidget.offsetX, 20);
  _DiscAnchorWidget({
    child,
    required double size,
    Alignment align = Alignment.center,
  }) : super(
          width: 0,
          height: 0,
          child: OverflowBox(
            maxHeight: size,
            minHeight: size,
            maxWidth: size,
            minWidth: size,
            alignment: align,
            child: Transform.translate(
              offset: defaultOffset,
              child: child,
            ),
          ),
        );
}
