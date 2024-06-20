import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

/// 상단에 반드시 size가 있는 위젯으로 감싸주어야 함. (width & height)
class OneLineTextWithMarquee extends StatelessWidget {
  final String text;
  final TextStyle style;
  final CrossAxisAlignment crossAxisAlignment;
  final Alignment alignment;
  const OneLineTextWithMarquee(
    this.text, {
    super.key,
    required this.style,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: AutoSizeText(
        text,
        style: style,
        maxLines: 1,
        minFontSize: style.fontSize!.toDouble(),
        overflowReplacement: Marquee(
          text: text,
          style: style,
          blankSpace: 100,
          velocity: 50,
          crossAxisAlignment: crossAxisAlignment,
          pauseAfterRound: const Duration(seconds: 3),
        ),
      ),
    );
  }
}
