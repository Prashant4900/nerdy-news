import 'package:flutter/material.dart';
import 'package:mobile/views/dashboard.dart';
import 'package:mobile/views/error/error_screen.dart';
import 'package:mobile/views/home/news_details_screen.dart';
import 'package:mobile/views/profile/feedback_screen.dart';
import 'package:mobile/views/profile/privacy_policy_screen.dart';
import 'package:mobile/views/profile/terms_screen.dart';
import 'package:mobile/views/share/share_image_screen.dart';
import 'package:mobile/views/start_screen.dart';
import 'package:news/news.dart';

part 'models.dart';

class MyRoutes {
  static const String newsDetailScreen = '/newsDetailScreen';
  static const String startScreen = '/startScreen';
  static const String dashboardScreen = '/dashboard';
  static const String feedbackScreen = '/feedbackScreen';
  static const String errorScreen = '/errorScreen';
  static const String shareImageScreen = '/shareImageScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String myTermScreen = '/myTermScreen';
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
      case MyRoutes.shareImageScreen:
        final args = settings.arguments! as ShareNewsArguments;
        return MaterialPageRoute(
          builder: (_) => MyShareImageScreen(news: args.newsModel),
        );
      case MyRoutes.feedbackScreen:
        return MaterialPageRoute(
          builder: (_) => const MyFeedbackScreen(),
        );
      case MyRoutes.errorScreen:
        // final args = settings.arguments! as ErrorMessageArguments;
        return MaterialPageRoute(
          builder: (_) => const MyErrorScreen(
              // message: args.details,
              ),
        );
      case MyRoutes.dashboardScreen:
        return MaterialPageRoute(
          builder: (_) => const MyDashboard(),
        );
      case MyRoutes.startScreen:
        return MaterialPageRoute(
          builder: (_) => const MyStartScreen(),
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
