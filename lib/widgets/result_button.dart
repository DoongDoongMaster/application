import 'package:application/models/play_result_model.dart';
import 'package:application/screens/result_screen.dart';
import 'package:application/services/api_service.dart';
import 'package:application/services/metronome.dart';
import 'package:flutter/material.dart';

class ResultButton extends StatelessWidget {
  const ResultButton({
    super.key,
    required this.audioFilePath,
    required this.delay,
    required this.metronome,
  });

  final String? audioFilePath;
  final int delay;
  final Metronome metronome;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(audioFilePath ?? ''),
        GestureDetector(
          onTap: () {
            Future<PlayResultModel> result = ApiService.uploadFile(
                filePath: audioFilePath!, delay: delay, bpm: metronome.bpm);

            result.then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => ResultScreen(playResultInstance: value),
                ),
              );
            });
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                '채점하기',
                style: TextStyle(fontSize: 18),
              )),
        ),
      ],
    );
  }
}
