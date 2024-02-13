import 'package:drift/drift.dart';

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

  static Expression<int> getTotalDurationInSec(
      Column<int> bpm, Expression<int> measureLength) {
    return (const Constant(4 * timeUnit) / bpm) * measureLength;
  }
}
