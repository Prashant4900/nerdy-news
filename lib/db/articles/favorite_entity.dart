import 'package:isar/isar.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/models/publisher_model.dart';

part 'favorite_entity.g.dart';

@collection
class FavoriteEntity {
  FavoriteEntity({
    this.news,
    this.newsId,
    this.id = Isar.autoIncrement,
  });

  final Id? id;

  @Index(unique: true)
  final int? newsId;
  final NewsModel? news;
}
