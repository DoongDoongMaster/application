import 'dart:async';

import 'package:flutter/foundation.dart';

class Metronome {
  static const countSize = 4;
  static const initialCount = -1;
  final ValueNotifier<int> count = ValueNotifier<int>(initialCount);
  late Timer _timer;
  final int bpm;
  late final int msPerBeat; // TODO: if msPerBeat is not integer!!!!

  Metronome({required this.bpm}) : msPerBeat = 60 * 1000 ~/ bpm;

  _onTick(Timer timer) {
    count.value++;
    if (count.value == 4) {
      count.value = 0;
    }
  }

  start() {
    _timer = Timer.periodic(Duration(milliseconds: msPerBeat), _onTick);

    // print('msPerbeat: $msPerBeat');
    count.value = 0;
  }

  stop() {
    _timer.cancel();
    count.value = initialCount;
  }
}
