import 'package:logger/logger.dart';

Logger customLogger() {
  return Logger(
    printer: PrettyPrinter(
      noBoxingByDefault: true,
      methodCount: 0,
      lineLength: 50,
    ),
  );
}
