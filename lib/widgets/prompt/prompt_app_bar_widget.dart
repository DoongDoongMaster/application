import 'package:application/screens/report_screen.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/one_line_text_with_marquee.dart';
import 'package:flutter/material.dart';

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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ReportScreen()));
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
  const _MusicTitleWidget({
    required this.musicTitle,
  });

  final String musicTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 50,
      child: OneLineTextWithMarquee(
        musicTitle,
        alignment: Alignment.center,
        style: TextStyles.headlineSmall,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
