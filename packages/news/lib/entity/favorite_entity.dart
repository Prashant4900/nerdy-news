// ignore_for_file: public_member_api_docs

import 'package:isar/isar.dart';
import 'package:news/model/model.dart';

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
