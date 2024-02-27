class TimeUtils {
  static int getUsPerBeat(int bpm) {
    return (Duration.secondsPerMinute * Duration.microsecondsPerSecond) ~/ bpm;
  }

  static int getSecPerBeat(int bpm) {
    return Duration.secondsPerMinute ~/ bpm;
  }

  static Duration getTotalDuration(int bpm, int measureLength) {
    return Duration(microseconds: getUsPerBeat(bpm) * measureLength * 4);
  }

  static int getTotalDurationInSec(int bpm, int measureLength) {
    return getTotalDuration(bpm, measureLength).inSeconds;
  }
}
