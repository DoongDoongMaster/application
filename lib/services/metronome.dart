import 'package:application/models/music_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/scheduler.dart';

typedef VoidCallback = void Function(CursorModel newCursor);

class Metronome {
  final MusicModel music;
  final VoidCallback callback;

  late Ticker _ticker;
  late final int usPerBeat;
  int usCounter = 0;

  int nextCursorTimestamp = 0;
  int nextCursorIdx = 0;
  late int offset;

  // for metronome sound
  //TODO: 속도 개선하기, 초반에 왜 밀리는지 해결, 더 나은 audio player혹은 파일 구해보기.
  final AssetSource _tickSoundSrc = AssetSource('sound/metronome.wav');
  static const int _audioPlayerSize = 3;
  final List<AudioPlayer> _audioPlayers = [
    for (int i = 0; i < _audioPlayerSize; i++) AudioPlayer()
  ];
  int _currentAudioIdx = 0;

  Metronome({
    required this.music,
    required this.callback,
  }) : usPerBeat = (60 * 1000000) ~/ music.bpm {
    _ticker = Ticker(_onTick);
    offset = usPerBeat * 4;
  }

  _onTick(Duration elasped) {
    // 1. play metronome
    if (elasped.inMicroseconds - usCounter >= usPerBeat) {
      usCounter = elasped.inMicroseconds;
      // print(elasped.inMicroseconds);
      // _player.resume();

      _audioPlayers[_currentAudioIdx].resume();

      _audioPlayers[
              (_currentAudioIdx - 1 + _audioPlayerSize) % _audioPlayerSize]
          .stop();
      _currentAudioIdx++;
      _currentAudioIdx %= _audioPlayerSize;
    }

    // 2. move cursor
    if (elasped.inMicroseconds >= nextCursorTimestamp + offset) {
      callback(music.cursorList[nextCursorIdx++]);

      if (nextCursorIdx == music.cursorList.length) {
        stop();
        return;
      }

      nextCursorTimestamp =
          (music.cursorList[nextCursorIdx].timestamp * 4 * usPerBeat).toInt();
    }
  }

  /// initialize player for metronome sound
  initialize() async {
    for (int i = 0; i < _audioPlayerSize; i++) {
      await _audioPlayers[i].setPlayerMode(PlayerMode.lowLatency);
      await _audioPlayers[i].setReleaseMode(ReleaseMode.stop);
      await _audioPlayers[i].setSource(_tickSoundSrc);
      await _audioPlayers[i].setVolume(0);
      await _audioPlayers[i].resume();

      await Future.delayed(const Duration(milliseconds: 300), () {
        _audioPlayers[i].stop();
      });

      await _audioPlayers[i].setVolume(1);
    }
  }

  start() {
    usCounter = usPerBeat;
    _ticker.start();
  }

  stop() {
    _ticker.stop();
    _ticker.dispose();

    for (int i = 0; i < _audioPlayerSize; i++) {
      _audioPlayers[i].dispose();
    }
  }
}
