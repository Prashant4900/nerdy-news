import 'package:flutter/material.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/models/publisher_model.dart';
import 'package:mobile/views/auth/auth_screen.dart';
import 'package:mobile/views/dashboard.dart';
import 'package:mobile/views/error/error_screen.dart';
import 'package:mobile/views/feedback/feedback_screen.dart';
import 'package:mobile/views/home/news_details_screen.dart';
import 'package:mobile/views/legal/privacy_policy_screen.dart';
import 'package:mobile/views/legal/terms_screen.dart';
import 'package:mobile/views/search/publisher_screen.dart';
import 'package:mobile/views/share/share_image_screen.dart';
import 'package:mobile/views/splash/splash_screen.dart';

part 'models.dart';

class MyRoutes {
  static const String newsDetailScreen = '/newsDetailScreen';
  static const String authScreen = '/authScreen';
  static const String dashboardScreen = '/dashboard';
  static const String feedbackScreen = '/feedbackScreen';
  static const String errorScreen = '/errorScreen';
  static const String shareImageScreen = '/shareImageScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String myTermScreen = '/myTermScreen';
  static const String splashScreen = '/splash';
  static const String publisherScreen = '/publisher';
}

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRoutes.newsDetailScreen:
        final args = settings.arguments! as NewsDetailArguments;
        return MaterialPageRoute(
          builder: (_) => NewsDetailScreen(
            news: args.newsModel,
          ),
        );
      case MyRoutes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const MySplashScreen(),
        );
      case MyRoutes.shareImageScreen:
        final args = settings.arguments! as ShareNewsArguments;
        return MaterialPageRoute(
          builder: (_) => MyShareImageScreen(news: args.newsModel),
        );
      case MyRoutes.publisherScreen:
        final args = settings.arguments! as PublisherArguments;
        return MaterialPageRoute(
          builder: (_) => MyPublisherScreen(publisher: args.model),
        );
      case MyRoutes.feedbackScreen:
        return MaterialPageRoute(
          builder: (_) => const MyFeedbackScreen(),
        );
      case MyRoutes.errorScreen:
        return MaterialPageRoute(
          builder: (_) => const MyErrorScreen(),
        );
      case MyRoutes.dashboardScreen:
        return MaterialPageRoute(
          builder: (_) => const MyDashboard(),
        );
      case MyRoutes.authScreen:
        return MaterialPageRoute(
          builder: (_) => const MyAuthScreen(),
        );
      case MyRoutes.privacyPolicyScreen:
        return MaterialPageRoute(
          builder: (_) => const MyPrivacyPolicyScreen(),
        );
      case MyRoutes.myTermScreen:
        return MaterialPageRoute(
          builder: (_) => const MyTermScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
