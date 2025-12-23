import 'package:logger/logger.dart';

class Loggerdef {
  static final bool isLoggerOn = false;
  static var logger = Logger(
    printer: PrettyPrinter(),
  );

  static var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );
}
