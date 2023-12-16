import 'package:get_it/get_it.dart';
import 'package:mobile/analytics/analytics.dart';
import 'package:mobile/feature/feedback/repository/feedback_repository.dart';
import 'package:mobile/repositories/auth_repository.dart';
import 'package:mobile/repositories/news_repository.dart';
import 'package:mobile/repositories/publisher_repository.dart';
import 'package:mobile/utils/supabase_config.dart';

final getIt = GetIt.instance;

final appAnalytics = getIt<AppAnalytics>();

Future<void> setup() async {
  getIt
    ..registerSingleton<SupabaseConfig>(SupabaseConfig())
    ..registerSingleton<NewsRepository>(const NewsRepository())
    ..registerSingleton<AuthRepository>(AuthRepository())
    ..registerSingleton<PublisherRepository>(const PublisherRepository())
    ..registerSingleton<FeedbackRepository>(const FeedbackRepository())
    ..registerSingleton<AppAnalytics>(AppAnalytics());
}
