import 'package:application/time_utils.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/screens/report_screen.dart';
import 'package:application/services/local_storage.dart';
import 'package:application/services/metronome.dart';
import 'package:application/services/recorder_service.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/prompt/practice_setting_modal.dart';
import 'package:application/widgets/prompt/prompt_app_bar_widget.dart';
import 'package:application/widgets/prompt/cursor_widget.dart';
import 'package:application/widgets/prompt/precount_widget.dart';
import 'package:application/widgets/prompt/prompt_footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

// TODO: 켜지는 속도 조절, 비상 종료 예외 처리 등

/// 삭제 시 안내 스낵바.
SnackBar buildSnackbar(BuildContext context) {
  return SnackBar(
    dismissDirection: DismissDirection.up,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 100,
      left: 400,
      right: 400,
    ),
    content: const Text('삭제되었습니다.',
        style: TextStyles.bodyMedium, textAlign: TextAlign.center),
    backgroundColor: ColorStyles.blackShadow80,
    duration: const Duration(seconds: 3),
  );
}

/// 프롬프트 화면
class PromptScreen extends StatefulWidget {
  final String? projectId;
  final MusicInfo music;
  const PromptScreen({
    super.key,
    required this.music,
    required this.projectId,
  });

  @override
  State<PromptScreen> createState() => PromptScreenState();
}

class PromptScreenState extends State<PromptScreen> {
  final RecorderService _recorder = RecorderService();
  final ScrollController _controller = ScrollController();
  late Metronome metronome;

  int? currentBPM;
  double? currentSpeed = 1.0;
  bool isMuted = false;

  late String dirPath;

  Cursors currentCursor = Cursors.createEmpty();
  double currentScrollYPos = 0;
  int currentSec = 0;
  int lengthInSec = 0;

  @override
  void initState() {
    if (widget.projectId == null) {
      context.pop();
    }
    super.initState();
    metronome = Metronome(
      music: widget.music,
      updateCursor: moveCursor,
      updateTime: updateTime,
      onComplete: completePractice,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPracticeSettingModal();
    });
  }

  Future<void> startPractice() async {
    dirPath = await LocalStorage.getLocalPath();
    await metronome.initialize();
    moveCursor(widget.music.cursorList[0]);
    await _recorder
        .startRecord('$dirPath/${DateTime.now().toIso8601String()}.m4a');

    metronome.start();

    setState(() {});
  }

  Future<void> stopPractice() async {
    currentSec = 0;
    currentScrollYPos = 0;

    metronome.stop();
    await _recorder.stopRecord();
  }

  Future<void> _showPrecountWidget(int usPerBeat) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), side: BorderSide.none),
        backgroundColor: ColorStyles.blackShadow36,
        content: PrecountWidget(
          usPerBeat: usPerBeat,
          startPractice: startPractice,
        ),
      ),
    );
  }

  triggerPractice() {
    _showPrecountWidget(metronome.usPerBeat);
  }

  Future<void> _showPracticeSettingModal() async {
    double? result = await showDialog<double>(
      context: context,
      barrierDismissible: false,
      // barrierColor: ColorStyles.blackShadow36,
      builder: (BuildContext context) => const PracticeSettingModal(),
    );

    setState(() {
      if (result != null) {
        currentSpeed = result;
      }
      metronome.setBPM((widget.music.bpm * currentSpeed!).toInt());
      lengthInSec =
          (widget.music.measureList.length * metronome.usPerBeat * 4) ~/
              TimeUtils.convertToMicro;
    });

// TODO: 종료 로직 다시 짜야 함.....
    if (result == -1) {
      setState(() {
        context.pop();
      });

      return;
    }

    triggerPractice();
  }

  /// 커서 이동 함수, 필요시, 다음 줄로 스크롤 진행
  moveCursor(Cursors newCursor) {
    int offset = 20;
    // if new line started
    if (newCursor.top - offset > currentScrollYPos) {
      currentScrollYPos = newCursor.top - offset;

      // only if there is space
      if (currentScrollYPos < _controller.position.maxScrollExtent) {
        _controller.animateTo(
          currentScrollYPos,
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

  updateTime(int currentTickInSec) {
    if (currentTickInSec != currentSec) {
      setState(() {
        currentSec = currentTickInSec;
      });
    }
  }

  metronomeOnOff() {
    metronome.setVolume(isMuted ? 1 : 0);
    setState(() {
      isMuted = !isMuted;
    });
  }

  /// '다시하기'
  restartPractice() async {
    ScaffoldMessenger.of(context).showSnackBar(buildSnackbar(context));

    await stopPractice();
    triggerPractice();
  }

  /// '취소하기'
  cancelPractice() async {
    ScaffoldMessenger.of(context).showSnackBar(buildSnackbar(context));

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PromptScreen(music: widget.music, projectId: widget.projectId),
        ));
  }

  /// 연습 완료 - 정상 종료
  completePractice() {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const ReportScreen()),
    // );
  }

  @override
  void dispose() {
    stopPractice();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95,
        automaticallyImplyLeading: false,
        title: PromptAppBarWidget(
          title: widget.music.title,
          artist: widget.music.artist,
          testFunction: () => _showPracticeSettingModal(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [ShadowStyles.shadow200],
              ),
              child: SingleChildScrollView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
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
                    ),
                    const SizedBox(
                      height: 100, // 하단 빈 영역, 없으면 너무 딱 맞춰서 끝날 수 있음.
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          PromptFooterWidget(
            originalBPM: widget.music.bpm,
            currentBPM: currentBPM,
            currentSpeed: currentSpeed,
            isMuted: isMuted,
            lengthInSec: lengthInSec,
            currentSec: currentSec,
            onPressMute: metronomeOnOff,
            onPressRestart: restartPractice,
            onPressCancel: cancelPractice,
          ),
        ],
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
