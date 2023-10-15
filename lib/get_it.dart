import 'package:analytics/analytics.dart';
import 'package:auth/auth.dart';
import 'package:feedback/feedback.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/services/supabase_config.dart';
import 'package:news/news.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

final appAnalytics = getIt<AppAnalytics>();

Future<void> setup() async {
  final dir = await getApplicationDocumentsDirectory();
  getIt
    ..registerSingleton<SupabaseConfig>(SupabaseConfig())
    ..registerSingleton<NewsRepository>(NewsRepository(dir.path))
    ..registerSingleton<MyAuth>(MyAuth())
    ..registerSingleton<FeedbackRepository>(const FeedbackRepository())
    ..registerSingleton<CacheHelper>(CacheHelper())
    ..registerSingleton<AppAnalytics>(AppAnalytics());
}
