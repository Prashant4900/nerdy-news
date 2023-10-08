// ignore_for_file: public_member_api_docs

import 'package:isar/isar.dart';
import 'package:news/model/model.dart';

part 'entity.g.dart';

@collection
class NewsEntity {
  NewsEntity({
    required this.news,
    this.isarId = Isar.autoIncrement,
  });

  final Id? isarId;
  final NewsModel news;
}
