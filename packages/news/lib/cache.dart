// ignore_for_file: public_member_api_docs

import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:news/entity/entity.dart';
import 'package:news/entity/favorite_entity.dart';
import 'package:news/model/model.dart';

class NewsCache {
  late final Isar isar;

  Future<void> init(String directory) async {
    isar = await Isar.open(
      [NewsEntitySchema, FavoriteEntitySchema],
      directory: directory,
    );
  }

  Future<void> insertNews(NewsModel news) async {
    try {
      final entity = NewsEntity(news: news);
      await isar.newsEntitys.put(entity);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> insertAllNews(List<NewsModel> news) async {
    try {
      final entities = news.map((model) => NewsEntity(news: model)).toList();
      await isar.newsEntitys.putAll(entities);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> insertFavorite(NewsModel news) async {
    try {
      final entity = FavoriteEntity(news: news);
      await isar.favoriteEntitys.put(entity);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteFavorite(NewsModel news) async {
    try {
      await isar.favoriteEntitys.deleteByNewsId(news.id);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<NewsModel>> getAllFavorite() async {
    try {
      final articles =
          await isar.collection<FavoriteEntity>().where().findAll();

      return articles.map((entity) => entity.news!).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
