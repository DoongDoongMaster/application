import 'package:application/time_utils.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/scheduler.dart';

class Metronome {
  /// 악보에 의존
  final MusicInfo music;
  final void Function(Cursors) updateCursor;
  final void Function(int) updateTime;
  final void Function() onComplete;
  double volume;

  /// 사용자가 선택한 속도
  late int currentBPM;
  late int usPerBeat;
  late int offset;

  /// 현재 상태 변수
  late Ticker _ticker;
  int usCounter = 0;
  int nextCursorTimestamp = 0;
  int nextCursorIdx = 0;
  int _currentAudioIdx = 0;

  // for metronome sound
  //TODO: 속도 개선하기, 초반에 왜 밀리는지 해결, 더 나은 audio player혹은 파일 구해보기.
  final AssetSource _tickSoundSrc = AssetSource('sound/metronome.wav');
  static const int _audioPlayerSize = 3;
  final List<AudioPlayer> _audioPlayers = [
    for (var i = 0; i < _audioPlayerSize; i++) AudioPlayer()
  ];

  Metronome({
    required this.updateTime,
    required this.music,
    required this.updateCursor,
    required this.onComplete,
    this.volume = 1,
  });

  _onTick(Duration elasped) {
    // 1. play metronome
    if (elasped.inMicroseconds - usCounter >= usPerBeat) {
      usCounter = elasped.inMicroseconds;
      // print(elasped.inMicroseconds);
      // _player.resume();

      _audioPlayers[_currentAudioIdx].resume();

      // _audioPlayers[
      //         (_currentAudioIdx - 1 + _audioPlayerSize) % _audioPlayerSize]
      //     .stop();
      _currentAudioIdx++;
      _currentAudioIdx %= _audioPlayerSize;
    }

    // 2. move cursor
    if (elasped.inMicroseconds >= nextCursorTimestamp + offset) {
      updateCursor(music.cursorList[nextCursorIdx++]);

      if (nextCursorIdx == music.cursorList.length) {
        nextCursorTimestamp += 8 * usPerBeat;
        Future.delayed(Duration(microseconds: 4 * usPerBeat), onComplete);
        return;
      }

      nextCursorTimestamp =
          (music.cursorList[nextCursorIdx].timestamp * 4 * usPerBeat).toInt();
    }

    // update time
    updateTime(
        (elasped.inMicroseconds - offset) ~/ Duration.microsecondsPerSecond);
  }

  /// initialize player for metronome sound
  Future<void> initialize(int bpm) async {
    currentBPM = bpm;
    usPerBeat = TimeUtils.getUsPerBeat(currentBPM);
    offset = usPerBeat * 4;

    usCounter = usPerBeat;
    nextCursorTimestamp = 0;
    nextCursorIdx = 0;
    _currentAudioIdx = 0;

    _ticker = Ticker(_onTick);

    for (int i = 0; i < _audioPlayerSize; i++) {
      var player = AudioPlayer();
      await player.setPlayerMode(PlayerMode.lowLatency);
      await player.setReleaseMode(ReleaseMode.stop);
      await player.setSource(_tickSoundSrc);
      // await player.setVolume(0);
      // await player.resume();

      // await Future.delayed(const Duration(milliseconds: 100), () {
      //   player.stop();
      //   player.setVolume(volume);
      // });

      _audioPlayers[i] = player;
    }
  }

  start() {
    if (_ticker.isActive) {
      throw Exception('already started');
    }
    _ticker.start();
  }

  Future<void> stop() async {
    if (_ticker.isActive) {
      _ticker.stop();
      _ticker.dispose();
    }
    for (int i = 0; i < _audioPlayerSize; i++) {
      await _audioPlayers[i].dispose();
    }
  }

  setVolume(double volume) {
    this.volume = volume;
    for (int i = 0; i < _audioPlayerSize; i++) {
      _audioPlayers[i].setVolume(volume);
    }
  }
}
