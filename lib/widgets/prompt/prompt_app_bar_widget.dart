import 'package:application/screens/complete_screen.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class PromptAppBarWidget extends StatelessWidget {
  final String title;
  final String artist;
  final void Function()? testFunction;

  const PromptAppBarWidget({
    super.key,
    required this.title,
    required this.artist,
    this.testFunction,
  });

  completePractice(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CompleteScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      color: ColorStyles.primary,
                    ),
                  ),
                ),
                _MusicTitleWidget(musicTitle: title),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => completePractice(context),
                          icon: const Icon(Icons.stop_circle),
                        ),
                        IconButton(
                          onPressed: testFunction,
                          icon: const Icon(Icons.play_circle),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              artist,
              style: TextStyles.bodyLarge
                  .copyWith(color: ColorStyles.secondaryShadow90),
            ),
          ],
        ),
      ),
    );
  }
}

class _MusicTitleWidget extends StatelessWidget {
  static const int maxTitleLength = 32;

  const _MusicTitleWidget({
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
