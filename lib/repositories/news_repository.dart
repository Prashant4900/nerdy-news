import 'package:mobile/models/news_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewsRepository {
  const NewsRepository();

  Future<List<NewsModel>?> getNewsByCategory({
    required SupabaseClient client,
    required int categoryID,
    int page = 0,
  }) async {
    try {
      final result = await client
          .from('news')
          .select<List<Map<String, dynamic>>>(
            '*,publisher_id(*),news_categories!inner(*)',
          )
          .filter('news_categories.categorymodel_id', 'eq', categoryID)
          .range(page, page + 10)
          .order('published_at', ascending: false)
          .onError((error, stackTrace) => throw Exception(error));

      return result.map(NewsModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<NewsModel>?> getAllNews({
    required SupabaseClient client,
    int page = 0,
  }) async {
    try {
      final result = await client
          .from('news')
          .select<List<Map<String, dynamic>>>(
            '*,publisher_id(*),news_categories!inner(*)',
          )
          .range(page, page + 10)
          .order('published_at', ascending: false)
          .onError((error, stackTrace) => throw Exception(error));

      return result.map(NewsModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<NewsModel>?> getNewsByPublisher({
    required SupabaseClient client,
    required int publisherID,
    int page = 0,
  }) async {
    try {
      final result = await client
          .from('news')
          .select<List<Map<String, dynamic>>>(
            '*,publisher_id(*),news_categories!inner(*)',
          )
          .filter('publisher_id', 'eq', publisherID)
          .range(page, page + 10)
          .order('published_at', ascending: false)
          .onError((error, stackTrace) => throw Exception(error));
      return result.map(NewsModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<NewsModel>?> getNewsByQuery({
    required SupabaseClient client,
    required String query,
    int page = 0,
  }) async {
    try {
      final result = await client
          .from('news')
          .select<List<Map<String, dynamic>>>(
            '*,publisher_id(*),news_categories!inner(*)',
          )
          .ilike('html_body', '%$query%')
          .range(page, page + 50)
          .order('published_at', ascending: false)
          .onError((error, stackTrace) => throw Exception(error));
      return result.map(NewsModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
