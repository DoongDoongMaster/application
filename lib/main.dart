import 'dart:async';
import 'package:application/services/local_storage.dart';
import 'package:application/services/metronome.dart';
import 'package:application/services/recorder_service.dart';
import 'package:application/widgets/metronome_widget.dart';
import 'package:application/widgets/result_button.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFFF931D),
        useMaterial3: true,
      ),
      home: const RecordPage(),
    );
  }
}

class RecordPage extends StatefulWidget {
  const RecordPage({
    super.key,
  });

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  bool isRecording = false;
  bool showMainMetronome = false;
  bool showResultButton = true;

  late RecorderService _recorder;
  late String dirPath;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  String? audioFilePath;
  late int delay = 0;
  late Metronome metronome = Metronome(bpm: 100);
  int barCount = 9;

  late DateTime recordStartPoint;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/video/demo-sheet-play.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    initialize();
  }

  initialize() async {
    dirPath = await LocalStorage.getLocalPath();
  }

  onPressedButton(context) async {
    setState(() {
      isRecording = !isRecording;
    });

    if (isRecording) {
      late DateTime dt1;
      _recorder = RecorderService(
          filePath: '$dirPath/${DateTime.now().toIso8601String()}.m4a');
      // start recording
      await _recorder.startRecord();
      dt1 = DateTime.now();
      // start timer
      metronome.start();
      Timer(
          Duration(
              milliseconds: metronome.msPerBeat * Metronome.countSize -
                  (DateTime.now().millisecondsSinceEpoch -
                      dt1.millisecondsSinceEpoch)), () async {
        var dtStart = DateTime.now();
        await _controller.play();
        var dtEnd = DateTime.now();
        setState(() {
          delay = dtEnd.microsecondsSinceEpoch - dtStart.microsecondsSinceEpoch;
        });
      });
      recordStartPoint = dt1;

      bool? result = await _dialogBuilder(
          context,
          metronome.count,
          metronome.msPerBeat * Metronome.countSize,
          dt1.millisecondsSinceEpoch);

      if (result == true) {
        showMainMetronome = true;

        Timer(
            Duration(
                milliseconds: ((barCount + 2) *
                        metronome.msPerBeat *
                        Metronome.countSize) -
                    (DateTime.now().millisecondsSinceEpoch -
                        dt1.millisecondsSinceEpoch)), () {
          // print("hihi");
          if (isRecording) {
            onPressedButton(context);
            setState(() {
              showResultButton = true;
            });
          }
        });
        return;
      }
    }

    metronome.stop();
    _controller.pause();
    _initializeVideoPlayerFuture = _controller.initialize();
    await _initializeVideoPlayerFuture;
    // var timeElaspedMs = DateTime.now().millisecondsSinceEpoch -
    //     recordStartPoint.millisecondsSinceEpoch;
    await _recorder.stopRecord();

    showMainMetronome = false;

    setState(() {
      audioFilePath = _recorder.filePath;
      print(audioFilePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: IconButton(
            onPressed: () => onPressedButton(context),
            icon:
                Icon(isRecording ? Icons.stop_circle : Icons.play_circle_fill),
            color: Colors.white,
            iconSize: 50,
          ),
        ),
      ),
      body: Column(
        children: [
          MetronomeWidget(
            listenable: metronome.count,
            isVisible: showMainMetronome,
            circleSize: 30,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          // audioFilePath != null
          //     ? AudioPlayer(
          //         filePath: audioFilePath!,
          //         delay: delay,
          //         bpm: metronome.bpm,
          //       )
          //     : const Text('no recording'),
          showResultButton
              ? ResultButton(
                  audioFilePath: audioFilePath,
                  delay: delay,
                  metronome: metronome)
              : const Text("Doong Doong Master"),
        ],
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<bool?> _dialogBuilder(
    BuildContext context,
    ValueListenable<int> metronomeCount,
    int msPerBar,
    int timestamp,
  ) {
    Timer(
        Duration(
            milliseconds: msPerBar -
                (DateTime.now().millisecondsSinceEpoch - timestamp)), () {
      Navigator.pop(context, true);
    });
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(50),
          content: MetronomeWidget(
            listenable: metronomeCount,
            isVisible: true,
            circleSize: 190,
          ),
        );
      },
    );
  }
}
