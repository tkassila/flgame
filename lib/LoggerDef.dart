import 'package:logger/logger.dart';

class Loggerdef {
  static final bool isLoggerOn = false;
  static var logger = Logger(
    printer: PrettyPrinter(),
  );

  static var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  static DateTime? startTime;
  static DateTime? endTime;
  static Duration? duration = Duration.zero;
  static String getDurationString() {
    if (startTime == null || endTime == null)
      {
        return "00:00:00";
      }
    else {
      duration = endTime!.difference(startTime!);
      return duration.toString();
      }
  }
}
