// ignore_for_file: public_member_api_docs

import 'package:isar/isar.dart';
import 'package:news/entity/entity.dart';
import 'package:news/entity/favorite_entity.dart';
import 'package:news/model/model.dart';
import 'package:supabase/supabase.dart';

/// {@template news}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class NewsRepository {
  NewsRepository(String directory) {
    _init(directory);
  }
  late Isar isar;

  Future<void> _init(String directory) async {
    isar = await Isar.open(
      [NewsEntitySchema, FavoriteEntitySchema],
      directory: directory,
    );
  }

  Future<List<NewsModel>?> getAllNews({
    required SupabaseClient client,
    int page = 0,
  }) async {
    try {
      print(client.restUrl);
      final result = await client
          .from('news')
          .select<List<Map<String, dynamic>>>('*,publisher_id(*)')
          .range(page, page + 10)
          .order('published_at', ascending: false)
          .onError((error, stackTrace) => throw Exception(error));

      return result.map(NewsModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<NewsModel>?> getWeeklyNews({
    required SupabaseClient client,
  }) async {
    try {
      final result = await client
          .from('news')
          .select<List<Map<String, dynamic>>>('*,publisher_id(*)')
          .gte('published_at', '2023-09-15T00:00:00+00')
          .order('published_at', ascending: false)
          .onError((error, stackTrace) => throw Exception(error));

      return result.map(NewsModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insertIntoFavorite(NewsModel newsModel) async {
    try {
      final entity = FavoriteEntity(news: newsModel, newsId: newsModel.id);
      await isar.writeTxn(() async {
        await isar.favoriteEntitys.put(entity);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteFavorite(NewsModel newsModel) async {
    try {
      await isar.writeTxn(() async {
        await isar.favoriteEntitys.deleteByNewsId(newsModel.id);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<NewsModel>> getAllFavorite() async {
    try {
      final articles =
          isar.collection<FavoriteEntity>().where().findAllSync().reversed;

      return articles.map((entity) => entity.news!).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> isItFavorite(NewsModel newsModel) async {
    try {
      final news = await isar.favoriteEntitys
          .filter()
          .newsIdEqualTo(newsModel.id)
          .findFirst();

      if (news == null) return false;
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
