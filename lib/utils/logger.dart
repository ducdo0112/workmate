import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    printEmojis: false,
    printTime: true,
    lineLength: 150,
  ),
  filter: MyFilter(),
);

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}
