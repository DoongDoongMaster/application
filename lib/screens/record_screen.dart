import 'package:application/models/music_model.dart';
import 'package:application/sample_music.dart';
import 'package:application/services/local_storage.dart';
import 'package:application/services/metronome.dart';
import 'package:application/services/recorder_service.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/cursor_widget.dart';
import 'package:application/widgets/precount_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({
    super.key,
  });

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late RecorderService _recorder;
  late Metronome metronome;
  final ScrollController _controller = ScrollController();

  final MusicModel music = MusicModel.fromJson(cursorInfo, bpm: 100);
  CursorModel currentCursor = CursorModel();

  late String dirPath;
  double currentPos = 0;

  // int tmpIdx = 0;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    metronome = Metronome(music: music, callback: moveCursor);
  }

  Future<void> _showPrecountWidget(int usPerBeat) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color(0x5c000000),
        // contentPadding: const EdgeInsets.all(50),
        content: PrecountWidget(
          usPerBeat: usPerBeat,
        ),
      ),
    );
  }

  void moveCursor(CursorModel newCursor) {
    int offset = 40;
    // if new line started
    if (newCursor.top - offset > currentPos) {
      currentPos = newCursor.top - offset;

      // only if there is space
      if (currentPos < _controller.position.maxScrollExtent) {
        _controller.animateTo(
          currentPos,
          duration: const Duration(seconds: 1),
          curve: Curves.linear,
        );
      }
    }

    setState(() {
      currentCursor = newCursor;
    });

    return;
  }

  startPractice() async {
    isPlaying = true;
    dirPath = await LocalStorage.getLocalPath();
    _recorder = RecorderService(
        filePath: '$dirPath/${DateTime.now().toIso8601String()}.m4a');
    await metronome.initialize();

    // start recording TODO: minimize delay (reliability)
    await _recorder.startRecord();

    metronome.start();
    _showPrecountWidget(metronome.usPerBeat);

    // moveCursor(music.cursorList[tmpIdx++]);
  }

  stopPractice() async {
    isPlaying = false;
    metronome.stop();
    await _recorder.stopRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 120,
        backgroundColor: ColorStyles.background,
        surfaceTintColor: ColorStyles.background,
        title: SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: const Icon(Icons.arrow_back_ios)),
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Stay with me",
                    style: TextStyles.headlineSmall,
                  ),
                  Text("자우림", style: TextStyles.bodySmall)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: isPlaying ? stopPractice() : startPractice,
                      icon: isPlaying
                          ? const Icon(Icons.stop_circle)
                          : const Icon(Icons.play_circle)),
                  const Text(
                    "BPM 100",
                    style: TextStyles.bodySmallLight,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 600,
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                child: Center(
                  child: Stack(
                    children: [
                      CursorWidget(
                        cursorInfo: currentCursor,
                      ),
                      SvgPicture.asset(
                        'assets/music/stay-with-me.svg',
                        width: 1024,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ],
                    // children: [],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.red),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.stop_circle),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.stop_circle),
                ),
              ],
            ),
          ),
        ],
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
