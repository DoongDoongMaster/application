import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MusicTitleWidget extends StatelessWidget {
  static const int maxTitleLength = 32;

  const MusicTitleWidget({
    super.key,
    required this.musicTitle,
  });

  final String musicTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 50,
      child: (musicTitle.length > maxTitleLength)
          ? Marquee(
              text: musicTitle,
              style: TextStyles.headlineSmall,
              // scrollAxis: Axis.horizontal,
              // crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 100.0,
              velocity: 50.0,
              pauseAfterRound: const Duration(seconds: 1),
              // startPadding: 10.0,
              // accelerationDuration: const Duration(seconds: 1),
              // accelerationCurve: Curves.linear,
              // decelerationDuration: const Duration(milliseconds: 500),
              // decelerationCurve: Curves.easeOut,
            )
          : Center(
              child: Text(
                musicTitle,
                style: TextStyles.headlineSmall,
              ),
            ),
    );
  }
}
