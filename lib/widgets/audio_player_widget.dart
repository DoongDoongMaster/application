import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AudioPlayer extends StatefulWidget {
  final String filePath;
  final int delay;
  final int bpm;

  const AudioPlayer(
      {super.key,
      required this.filePath,
      required this.delay,
      required this.bpm});

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  bool isAudioPlaying = false;
  late VideoPlayerController _audioController;
  late Future<void> _initializeAudioPlayerFuture;

  @override
  void initState() {
    super.initState();

    _audioController = VideoPlayerController.file(File(widget.filePath));
    _initializeAudioPlayerFuture = _audioController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder(
              future: _initializeAudioPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // _audioController.value.duration;
                  // print(
                  // '${widget.filePath} >> duration: ${_audioController.value.duration}');
                  return IconButton(
                      onPressed: () {
                        if (isAudioPlaying) {
                          _audioController.pause();
                        } else {
                          _audioController.play();
                        }
                        setState(() {
                          isAudioPlaying = !isAudioPlaying;
                        });
                      },
                      icon: Icon(
                          isAudioPlaying ? Icons.pause : Icons.play_arrow));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
