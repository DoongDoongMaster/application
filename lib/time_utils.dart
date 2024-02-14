class TimeUtils {
  static const int timeUnit = 60;
  static const int convertToMilli = 1000;
  static const int convertToMicro = 1000000;

  static int getUsPerBeat(int bpm) {
    return (timeUnit * convertToMicro) ~/ bpm;
  }

  static int getSecPerBeat(int bpm) {
    return timeUnit ~/ bpm;
  }

  static Duration getTotalDuration(int bpm, int measureLength) {
    return Duration(microseconds: getUsPerBeat(bpm) * measureLength * 4);
  }

  static int getTotalDurationInSec(int bpm, int measureLength) {
    return getTotalDuration(bpm, measureLength).inSeconds;
  }
}
