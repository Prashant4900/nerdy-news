import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class AppCrashlytics {
  static Future<void> init() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static void recodeError(
    dynamic exception,
    StackTrace? stack,
  ) {
    FirebaseCrashlytics.instance.recordError(exception, stack);
  }

  static void forceCrash() {
    FirebaseCrashlytics.instance.crash();
  }
}
