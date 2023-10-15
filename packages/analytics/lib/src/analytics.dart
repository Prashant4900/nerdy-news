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

  Future<void> setUserID(String userID) async {
    await analytics.setUserId(id: userID);
  }

  final analytics = FirebaseAnalytics.instance;

  Future<void> log(
    LogEvent event, {
    String? screenClass,
    String? screenName,
    ShareType shareType = ShareType.link,
    int? newsID,
    String? newsTitle,
  }) async {
    switch (event) {
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
        assert(
          newsID != null && newsTitle != null,
          'News ID and Title must be not null',
        );
        await analytics.logShare(
          contentType: shareType.label,
          itemId: 'ID: $newsID - Title: $newsTitle',
          method: shareType.label,
        );
      case LogEvent.logOut:
        await analytics.logEvent(name: 'log_out');
    }
  }

  Future<void> set(String screenName) async {
    await analytics.setCurrentScreen(screenName: screenName);
  }
}
