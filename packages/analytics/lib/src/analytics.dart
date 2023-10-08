import 'package:analytics/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalytics {
  static Future<void> init() async {
    final analytics = FirebaseAnalytics.instance;

    await analytics.setConsent(
      adStorageConsentGranted: true,
      analyticsStorageConsentGranted: true,
    );
    await analytics.setAnalyticsCollectionEnabled(true);
    await analytics.logAppOpen();
  }

  final analytics = FirebaseAnalytics.instance;

  Future<void> log({
    LogEvent event = LogEvent.none,
    String? name,
    String? screenClass,
    String? screenName,
  }) async {
    switch (event) {
      case LogEvent.none:
        await analytics.logEvent(name: name!);
      case LogEvent.logIn:
        await analytics.logLogin();
      case LogEvent.appOpen:
        await analytics.logAppOpen();
      case LogEvent.screenView:
        await analytics.logScreenView(
          screenClass: screenClass,
          screenName: screenName,
        );
      case LogEvent.share:
      // analytics.logShare(
      //   contentType: contentType,
      //   itemId: itemId,
      //   method: method,
      // );
      case LogEvent.signUp:
      // analytics.logSignUp(signUpMethod: signUpMethod);
    }
  }
}
