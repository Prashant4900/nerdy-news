import 'package:isar/isar.dart';
import 'package:mobile/db/articles/favorite_entity.dart';
import 'package:mobile/models/news_model.dart';
import 'package:path_provider/path_provider.dart';

class FavoriteRepository {
  FavoriteRepository() {
    _init();
  }

  late Isar isar;

  Future<void> _init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [FavoriteEntitySchema],
      directory: dir.path,
    );
  }

  Future<void> insertIntoFavorite(NewsModel newsModel) async {
    try {
      final entity = FavoriteEntity(news: newsModel, newsId: newsModel.id);
      await isar.writeTxn(() async {
        await isar.favoriteEntitys.put(entity);
      });
    } catch (e) {
      throw Exception('Failed to Insert in Favorite Error: $e');
    }
  }

  Future<bool> deleteFavorite(NewsModel newsModel) async {
    try {
      var flag = false;
      await isar.writeTxn(() async {
        flag = await isar.favoriteEntitys.deleteByNewsId(newsModel.id);
      });
      return flag;
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
