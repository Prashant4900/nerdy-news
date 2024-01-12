import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:mobile/models/publisher_model.dart';

part 'news_model.g.dart';

@embedded
class NewsModel {
  NewsModel({
    this.id,
    this.title,
    this.description,
    this.htmlBody,
    this.thumbnail,
    this.views,
    this.shares,
    this.likes,
    this.source,
    this.publishedAt,
    this.publisherModel,
    this.newsId,
  });

  factory NewsModel.fromJson(String str) =>
      NewsModel.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        htmlBody: json['html_body'] as String?,
        thumbnail: json['thumbnail'] as String?,
        views: json['views'] as int?,
        shares: json['shares'] as int?,
        likes: json['likes'] as int?,
        source: json['source'] as String?,
        publishedAt: DateTime.parse(json['published_at'] as String),
        publisherModel: PublisherModel.fromMap(
          json['publisher_id'] as Map<String, dynamic>,
        ),
        newsId: json['news_id'] as String?,
      );
  final int? id;
  final String? title;
  final String? description;
  final String? htmlBody;
  final String? thumbnail;
  final int? views;
  final int? shares;
  final int? likes;
  final String? source;
  final DateTime? publishedAt;
  final PublisherModel? publisherModel;
  final String? newsId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'html_body': htmlBody,
        'thumbnail': thumbnail,
        'views': views,
        'shares': shares,
        'likes': likes,
        'source': source,
        'published_at': publishedAt?.toIso8601String(),
        'publisher_id': publisherModel?.toMap(),
        'news_id': newsId,
      };
}
