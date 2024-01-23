import 'package:application/screens/complete_screen.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/music_title_widget.dart';
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
                MusicTitleWidget(musicTitle: title),
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
