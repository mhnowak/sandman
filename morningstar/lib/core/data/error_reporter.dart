import 'dart:developer';

import 'package:flutter/foundation.dart';

class ErrorReporter {
  ErrorReporter([this._shouldLog = kDebugMode]);

  final bool _shouldLog;

  void logError(dynamic error, [StackTrace? stack]) {
    if (_shouldLog) {
      log('Unexpected error occured: ${error.toString()}', stackTrace: stack);
    }
  }
}
