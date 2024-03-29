import 'package:application/main.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/practice_infos.dart';
import 'package:application/router.dart';
import 'package:application/screens/home_screen.dart';
import 'package:application/services/api_service.dart';
import 'package:application/services/local_storage.dart';
import 'package:application/services/metronome.dart';
import 'package:application/services/recorder_service.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/time_utils.dart';
import 'package:application/widgets/prompt/cursor_widget.dart';
import 'package:application/widgets/prompt/practice_setting_modal.dart';
import 'package:application/widgets/prompt/precount_widget.dart';
import 'package:application/widgets/prompt/prompt_app_bar_widget.dart';
import 'package:application/widgets/prompt/prompt_footer_widget.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

enum PromptState {
  waiting,
  initializing,
  starting,
  playing,
}

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

class PromptScreen extends StatefulWidget {
  static const double sheetPadding = 40;
  final String? musicId, projectId;
  const PromptScreen({
    super.key,
    required this.musicId,
    required this.projectId,
  });

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  MusicInfo music = MusicInfo();
  PracticeInfo practice = PracticeInfo(speed: 0);

  late Metronome _metronome;

  final ScrollController _controller = ScrollController();
  Cursors currentCursor = Cursors.createEmpty();
  static const int cursorOffset = 20;
  PromptState state = PromptState.waiting;

  int currentSec = 0;
  int totalLengthInSec = 0;

  final RecorderService _recorder = RecorderService();

  /// user settings...
  bool isMuted = false;
  int currentBPM = 90;
  double speed = 0;

  @override
  void initState() {
    super.initState();

    /**
     * 1. _showPracticeSettingModal
     *    - loadMusic
     *    - wait for user setting (speed)
     * 2. _showPrecountWidget
     *    - startPractice
     */
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _showPracticeSettingModal());
  }

  /// handle user input (speed)
  Future<void> _showPracticeSettingModal() async {
    late final double? result;
    await Future.wait([
      loadMusic(widget.musicId!),
      () async {
        result = await showDialog<double>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const PracticeSettingModal(),
        );
      }()
    ]);

    if (result == null) {
      if (context.mounted) {
        if (context.canPop()) {
          context.pop();
        } else {
          context.pushReplacementNamed(RouterPath.home.name,
              pathParameters: {"tab": HomeTab.projectList.name, "refresh": ''});
        }
      }
      return;
    }

    setState(() {
      speed = result!;
      state = PromptState.initializing;
      currentBPM = (music.bpm * speed).toInt();
      totalLengthInSec =
          TimeUtils.getTotalDuration(currentBPM, music.measureCount).inSeconds;
    });
    _showPrecountWidget();
  }

  /// trigger precount & start metronome
  Future<void> _showPrecountWidget() async {
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
          usPerBeat: TimeUtils.getUsPerBeat(currentBPM),
          startPractice: startPractice,
        ),
      ),
    );
  }

  /// 악보 불러오기
  Future<void> loadMusic(String id) async {
    final temp = await (database.select(database.musicInfos)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (temp == null && context.mounted) {
      context.goNamed(RouterPath.home.name);
      return;
    }

    setState(() {
      music = temp!;
      _metronome = Metronome(
        updateTime: updateTime,
        music: music,
        updateCursor: updateCursor,
        onComplete: finishPractice,
        volume: isMuted ? 0 : 1,
      );
    });

    // UI가 모두 업데이트 된 이후에 커서 업데이트가 진행되어야 함
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (music.cursorList.isNotEmpty) {
        updateCursor(music.cursorList[0]);
      }
    });
  }

  void toggleMute() {
    if (state == PromptState.playing || state == PromptState.starting) {
      _metronome.setVolume(isMuted ? 1 : 0);
    }
    setState(() {
      isMuted = !isMuted;
    });
  }

  /// 진행 시간 업데이트
  void updateTime(int currentTickInSec) {
    if (state == PromptState.playing &&
        currentTickInSec != currentSec &&
        currentTickInSec <= totalLengthInSec) {
      setState(() {
        currentSec = currentTickInSec;
      });
    }
  }

  /// update cursor & scroll down if needed.
  void updateCursor(Cursors newCursor) {
    // y가 바뀐 경우
    if (currentCursor.y != newCursor.y) {
      final scrollYPos = newCursor.y - cursorOffset;
      // only if there is space
      if (scrollYPos < _controller.position.maxScrollExtent) {
        _controller.animateTo(
          scrollYPos,
          duration: const Duration(seconds: 1),
          curve: Curves.linear,
        );
      }
    }
    // update cursor
    setState(() {
      currentCursor = newCursor;
    });
  }

  /// create practice in DB
  Future<void> createPractice() async {
    // create practice
    final temp = await database
        .into(database.practiceInfos)
        .insertReturningOrNull(PracticeInfosCompanion.insert(
          projectId: widget.projectId!,
          speed: drift.Value(speed),
        ));

    if (temp != null) {
      setState(() {
        practice = temp;
      });
    }
  }

  /// create practice, start record & metronome
  Future<void> startPractice() async {
    late final String dirPath;

    await Future.wait([
      // 1. 연습 생성
      createPractice(),
      // 2. 녹음 서비스 초기화
      _recorder.initialize(),
      // 3. 현재 path 구하기
      () async {
        dirPath = await LocalStorage.getLocalPath();
      }(),
      // 4. 메트로놈 초기화
      _metronome.initialize(currentBPM),
    ]);

    state = PromptState.starting;
    Future.delayed(Duration(microseconds: _metronome.offset),
        () => state = PromptState.playing);
    // 녹음 시작
    await _recorder.startRecord('$dirPath/${practice.id}.m4a');
    _metronome.start();
  }

  void submitRecord(String filePath) async {
    var result =
        await ApiService.getADTResult(dataPath: filePath, bpm: currentBPM);
    if (result == null) {
      return;
    }

    result.calculateWithAnswer(music.musicEntries);

    // TODO: 종료 시 API 호출 필요. + push 알림 등 처리 필요
    (database.update(database.practiceInfos)
          ..where((tbl) => tbl.id.equals(practice.id)))
        .write(
      PracticeInfosCompanion(
        isNew: const drift.Value(true),
        score: drift.Value(result.score),
        accuracyCount: drift.Value(result.accuracyCount),
        componentCount: drift.Value(result.componentCount),
        transcription: drift.Value(result.transcription),
      ),
    );
  }

  /// stop metronome, finish record, api call, redirection
  void finishPractice() async {
    _metronome.stop();
    final filePath = await _recorder.stopRecord();
    // 필요한거 정리.
    _recorder.dispose();
    if (filePath != null) {
      submitRecord(filePath);
    } else {
      print("file not saved!!!!");
    }
    if (context.mounted) {
      context.pop();
    }
  }

  /// clean off practice data in DB, record, state
  cleanOffPractice() {
    currentSec = 0;
    ScaffoldMessenger.of(context).showSnackBar(buildSnackbar(context));

    return Future.wait(<Future<dynamic>>[
      database.deletePractice(practice.id),
      _metronome.stop(),
      _recorder.stopRecord(),
    ]);
  }

  /// restart practice with current user setting (speed)
  void restartPractice() async {
    state = PromptState.initializing;
    await cleanOffPractice();
    _showPrecountWidget();
  }

  /// start new practice
  void cancelPractice() async {
    state = PromptState.waiting;
    await cleanOffPractice();
    _showPracticeSettingModal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95,
        automaticallyImplyLeading: false,
        title: PromptAppBarWidget(
          title: music.title,
          artist: music.artist,
          exitPractice: () async {
            await cleanOffPractice();
            if (context.mounted) {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed(RouterPath.home.name);
              }
            }
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: music.sheetImage != null
                ? DecoratedBox(
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: PromptScreen.sheetPadding),
                                child: Image.memory(
                                  music.sheetImage!,
                                  width: 1024,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 100, // 하단 빈 영역, 없으면 너무 딱 맞춰서 끝날 수 있음.
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          const SizedBox(
            height: 25,
          ),
          PromptFooterWidget(
            originalBPM: music.bpm,
            isMuted: isMuted,
            onPressMute: toggleMute,
            lengthInSec: totalLengthInSec,
            currentSec: currentSec,
            onPressRestart:
                state == PromptState.playing ? restartPractice : null,
            onPressCancel: state == PromptState.playing ? cancelPractice : null,
            currentBPM: practice.bpm,
            currentSpeed: practice.speed,
          ),
        ],
      ),
    );
  }
}
