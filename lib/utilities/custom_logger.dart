import 'package:logger/logger.dart';

Logger customLogger() {
  return Logger(
    printer: CustomPrinter(),
  );
}

class CustomPrinter extends LogPrinter {
  final PrettyPrinter _defaultPrinter = PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 0,
    noBoxingByDefault: true,
    excludePaths: [
      "package:zineapp2023/utilities/custom_logger.dart",
    ], // Excluding the logger itself from logging,
    lineLength: 50,
  );
  final PrettyPrinter _errorPrinter = PrettyPrinter(
    methodCount: 2,
    excludePaths: [
      "package:zineapp2023/utilities/custom_logger.dart",
    ], // Excluding the logger itself from logging,
    lineLength: 50,
  );

  @override
  List<String> log(LogEvent event) {
    if (event.level == Level.error) {
      return _errorPrinter.log(event);
    } else {
      return _defaultPrinter.log(event);
    }
  }
}
