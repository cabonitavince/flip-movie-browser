import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final _logger = Logger();

  static void _log(VoidCallback logFunction) {
    if (kDebugMode) {
      logFunction();
    }
  }

  static void v(String message, {dynamic error, StackTrace? stackTrace}) {
    _log(() => _logger.t(message, error: error, stackTrace: stackTrace));
  }

  static void d(String message, {dynamic error, StackTrace? stackTrace}) {
    _log(() => _logger.d(message, error: error, stackTrace: stackTrace));
  }

  static void i(String message, {dynamic error, StackTrace? stackTrace}) {
    _log(() => _logger.i(message, error: error, stackTrace: stackTrace));
  }

  static void w(String message, {dynamic error, StackTrace? stackTrace}) {
    _log(() => _logger.w(message, error: error, stackTrace: stackTrace));
  }

  static void e(String message, {dynamic error, StackTrace? stackTrace}) {
    _log(() => _logger.e(message, error: error, stackTrace: stackTrace));
  }

  static void f(String message, {dynamic error, StackTrace? stackTrace}) {
    _log(() => _logger.f(message, error: error, stackTrace: stackTrace));
  }
}
