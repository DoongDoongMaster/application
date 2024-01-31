import 'package:application/models/music_model.dart';
import 'package:application/sample_music.dart';
import 'package:application/screens/record_screen.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecordScreen(
                    music: MusicModel.fromJson(sheetInfo,
                        bpm: 100, title: 'Stay with me', artist: '자우림')),
              ),
            );
          },
          child: const Text(
            "Stay with me 완곡 연주",
            style: TextStyles.displayLarge,
          ),
        ),
      ),
    );
  }
}
