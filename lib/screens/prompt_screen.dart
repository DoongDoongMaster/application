import 'dart:math';

import 'package:application/main.dart';
import 'package:application/models/adt_result_model.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/default_report_info.dart';
import 'package:application/models/entity/drill_info.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/router.dart';
import 'package:application/screens/home_screen.dart';
import 'package:application/services/local_storage.dart';
import 'package:application/services/metronome.dart';
import 'package:application/services/recorder_service.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/time_utils.dart';
import 'package:application/widgets/positioned_container.dart';
import 'package:application/widgets/prompt/cursor_widget.dart';
import 'package:application/widgets/prompt/prompt_setting_modal.dart';
import 'package:application/widgets/prompt/precount_widget.dart';
import 'package:application/widgets/prompt/prompt_app_bar_widget.dart';
import 'package:application/widgets/prompt/prompt_footer_widget.dart';
import 'package:application/widgets/show_snackbar.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

enum PromptState {
  waiting, // 처음
  initializing, // music, drillInfo, metronome 준비 완료
  starting, //
  playing,
}

class PromptScreen extends StatefulWidget {
  final String? musicId, projectId, drillId;
  const PromptScreen({
    super.key,
    required this.musicId,
    required this.projectId,
    this.drillId,
  });

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  MusicInfo music = MusicInfo();
  DefaultReportInfo report = DefaultReportInfo();
  late PromptOption _option;
  DrillInfo? drillInfo;
  final List<Cursor> blurSections = [];

  late Metronome _metronome;

  final ScrollController _controller = ScrollController();
  Cursor currentCursor = Cursor.createEmpty();
  static const int cursorOffset = 170;
  PromptState state = PromptState.waiting;

  int currentSec = 0;
  int totalLengthInSec = 0;
  int currentCount = 0;
  int lengthPerCountInMs = 0;

  final RecorderService _recorder = RecorderService();

  /// user settings...
  bool isMuted = true;

  @override
  void initState() {
    super.initState();
    _option = PromptOption(
        type: (widget.drillId == null) ? ReportType.full : ReportType.drill);
    /**
     * 1. showPracticeSettingModal
     *    - getMusicInfo
     *    - loadMetronome
     *    - wait for user setting (speed)
     * 2. showPrecountWidget
     *    - startPractice
     */

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _showPracticeSettingModal());
  }

  /// 음악 정보 불러오기
  Future<void> _getMusicInfo() async {
    // 악보 불러오기
    MusicInfo? musicInfo = await (database.select(database.musicInfos)
          ..where((tbl) => tbl.id.equals(widget.musicId!)))
        .getSingleOrNull();
    // 악보 없는 경우 -> 나가기
    if (musicInfo == null) {
      _goBack();
      return;
    } else {
      setState(() {
        music = musicInfo;
        _option.originalBPM = music.bpm;
        _option.currentBPM = music.bpm;
      });
    }
  }

  /// drill 정보 가져와서, music 변경하기
  Future<void> _getDrillInfo() async {
    drillInfo = await (database.select(database.drillInfos)
          ..where((tbl) => tbl.id.equals(widget.drillId!)))
        .getSingle();

    if (drillInfo == null) {
      _goBack();
      return;
    }

    // 기존 음악 정보 자르기
    music = music.extractDrillPart(drillInfo!, _option);
    // 마스킹 생성.
    blurSections.addAll([
      // 상단 패딩 부분
      Cursor(
        x: 0,
        y: 0,
        w: MusicInfo.imageWidth,
        h: music.cursorList.first.y - 20,
        ts: 0,
      ),
      // 시작 줄 앞 부분
      Cursor(
        x: 0,
        w: music.measureList.first.x,
        y: music.cursorList.first.y,
        h: music.cursorList.first.h,
        ts: 0,
      ),
      // 마지막 마디 뒷 부분
      Cursor(
        x: music.measureList.last.x + music.measureList.last.w,
        w: MusicInfo.imageWidth -
            music.measureList.last.x +
            music.measureList.last.w,
        y: music.cursorList.last.y,
        h: music.cursorList.last.h + MusicInfo.cropPaddingBottom,
        ts: 0,
      ),
      // 다음 줄 부분
      Cursor(
        x: 0,
        w: MusicInfo.imageWidth,
        y: music.cursorList.last.y +
            music.cursorList.last.h +
            MusicInfo.cropPaddingBottom,
        h: 1000,
        ts: 0,
      ),
    ]);
  }

  /// 뒤로 가기
  void _goBack() {
    if (context.mounted) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.pushReplacementNamed(RouterPath.home.name,
            pathParameters: {"tab": HomeTab.projectList.name, "refresh": ''});
      }
    }
  }

  /// handle user input (speed)
  Future<void> _showPracticeSettingModal() async {
    PromptOption? result;
    // 1. 음악 정보 가져오기
    await _getMusicInfo();
    var sourceCnt = music.sourceCnt;
    var hitCnt = music.hitCnt;

    await Future.wait([
      // 2. 구간 연습인 경우 정보 가져오고, 업데이트
      if (widget.drillId != null) _getDrillInfo(),
      if (mounted)
        showDialog<PromptOption>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => PromptSettingModal(
            drillId: widget.drillId,
            promptOption: _option,
            sourceCnt: sourceCnt,
            hitCnt: hitCnt,
          ),
        ).then((value) => result = value)
    ]);
    // else // TODO:구간 연습용 설정 모달 만들기!!!!

    if (result == null) {
      _goBack();
      return;
    }

    _option = result!;
    lengthPerCountInMs =
        TimeUtils.getTotalDuration(_option.currentBPM, music.measureCnt)
            .inMilliseconds;

    // 여러번 진행할 경우 커서 및 measure 늘리기.
    if (_option.count > 1) {
      // HACK: 좀 더 효율적인 방법으로 바꿀 필요 있음
      List<Cursor> additionalCursor = [], additionalMeasure = [];
      var tsPerCount = music.measureList.last.ts + 1;
      for (var i = 1; i < _option.count; i++) {
        additionalCursor.addAll(
            music.cursorList.map((e) => e.copyWith(ts: e.ts + i * tsPerCount)));
        additionalMeasure.addAll(music.measureList
            .map((e) => e.copyWith(ts: e.ts + i * tsPerCount)));
      }
      music.cursorList.addAll(additionalCursor);
      music.measureList.addAll(additionalMeasure);
    }

    _loadMetronome();

    setState(() {
      state = PromptState.initializing;

      totalLengthInSec =
          TimeUtils.getTotalDuration(_option.currentBPM, music.measureCnt)
              .inSeconds;
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
          usPerBeat: TimeUtils.getUsPerBeat(_option.currentBPM),
          startPractice: startPractice,
        ),
      ),
    );
  }

  /// metronome 세팅, 커서 초기화
  _loadMetronome() {
    setState(() {
      _metronome = Metronome(
        updateTime: updateTime,
        music: music,
        updateCursor: updateCursor,
        onComplete: finishPractice,
        volume: isMuted ? 0 : 1,
      );
      currentCount++;
    });

    // UI가 모두 업데이트 된 이후에 커서 업데이트가 진행되어야 함
    SchedulerBinding.instance.addPostFrameCallback((_) {
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
      currentSec = currentTickInSec;
    }

    if (widget.drillId != null &&
        currentCount < _option.count &&
        currentSec * 1000 >= currentCount * lengthPerCountInMs) {
      currentCount++;
    }
    setState(() {});
  }

  /// update cursor & scroll down if needed.
  void updateCursor(Cursor newCursor) {
    // y가 바뀐 경우
    if (currentCursor.y != newCursor.y) {
      final scrollYPos = max(newCursor.y - cursorOffset, 0.0);
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

  /// create report in DB
  Future<void> _createReport() async {
    late DefaultReportInfo? temp;
    if (widget.drillId == null) {
      temp = await database
          .into(database.practiceInfos)
          .insertReturningOrNull(PracticeInfosCompanion.insert(
            projectId: widget.projectId!,
            speed: drift.Value(_option.speed),
            bpm: _option.currentBPM,
          ));
    } else {
      temp = await database
          .into(database.drillReportInfos)
          .insertReturningOrNull(DrillReportInfosCompanion.insert(
            bpm: _option.currentBPM,
            drillId: widget.drillId!,
            count: drift.Value(_option.count),
          ));
    }

    if (temp != null) {
      setState(() {
        report = temp!;
      });
    }
  }

  /// create practice, start record & metronome
  Future<void> startPractice() async {
    late final String dirPath;

    await Future.wait([
      // 1. 연습 생성
      _createReport(),
      // 2. 녹음 서비스 초기화
      _recorder.initialize(),
      // 3. 현재 path 구하기
      () async {
        dirPath = await LocalStorage.getLocalPath();
      }(),
      // 4. 메트로놈 초기화
      _metronome.initialize(_option.currentBPM),
    ]);

    state = PromptState.starting;
    Future.delayed(Duration(microseconds: _metronome.offset),
        () => state = PromptState.playing);
    // 녹음 시작
    await _recorder.startRecord('$dirPath/${report.id}.wav');
    _metronome.start();
  }

  /// stop metronome, finish record, api call, redirection
  void finishPractice() async {
    _metronome.stop();
    final filePath = await _recorder.stopRecord();
    // 필요한거 정리.
    _recorder.dispose();
    if (filePath != null) {
      ADT.run(
        reportId: report.id,
        musicId: music.id,
        filePath: filePath,
        answer: music.musicEntries,
        measureCnt: music.measureCnt,
        context: context.mounted ? context : null,
        option: _option,
      );
    } else {
      if (context.mounted) {
        showSnackbar(context, '오류가 발생했습니다. - 녹음 저장 실패');
      }
    }

    switch (_option.type) {
      case ReportType.full:
        _goBack();
        break;
      case ReportType.drill:
        if (mounted) {
          context.pushReplacementNamed(RouterPath.prompt.name, pathParameters: {
            "musicId": music.id,
            "projectId": drillInfo!.projectId,
          }, queryParameters: {
            "drillId": drillInfo!.id,
          });
        }
    }
  }

  /// clean up practice data in DB, record, state
  _cleanUpPractice() {
    currentSec = 0;
    showSnackbar(context, '삭제되었습니다.');

    return Future.wait(<Future<dynamic>>[
      database.deleteReport(report.id, _option.type),
      if (state != PromptState.waiting) _metronome.stop(),
      if (_recorder.isReady) _recorder.stopRecord(),
    ]);
  }

  /// restart practice with current user setting (speed)
  void restartPractice() async {
    state = PromptState.initializing;
    await _cleanUpPractice();
    _loadMetronome();
    _showPrecountWidget();
  }

  /// start new practice
  void cancelPractice() async {
    state = PromptState.waiting;
    await _cleanUpPractice();
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
            await _cleanUpPractice();
            _goBack();
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
                                cursor: currentCursor,
                              ),
                              Image.memory(
                                music.sheetImage!,
                                width: MusicInfo.imageWidth,
                              ),
                              ...blurSections.map(
                                (e) => PositionedContainer(
                                  cursor: e,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9)),
                                ),
                              )
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
            isMuted: isMuted,
            onPressMute: toggleMute,
            lengthInSec: totalLengthInSec,
            currentSec: currentSec,
            onPressRestart:
                state == PromptState.playing ? restartPractice : null,
            onPressCancel: state == PromptState.playing ? cancelPractice : null,
            option: _option,
            currentCount: currentCount,
          ),
        ],
      ),
    );
  }
}
