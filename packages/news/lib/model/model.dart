// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:isar/isar.dart';

part 'model.g.dart';

@embedded
class NewsModel {
  NewsModel({
    this.id,
    this.title,
    this.description,
    this.htmlBody,
    this.thumbnail,
    this.views,
    this.source,
    this.publishedAt,
    this.publisherModel,
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
        source: json['source'] as String?,
        publishedAt: DateTime.parse(json['published_at'] as String),
        publisherModel: PublisherModel.fromMap(
          json['publisher_id'] as Map<String, dynamic>,
        ),
      );
  final int? id;
  final String? title;
  final String? description;
  final String? htmlBody;
  final String? thumbnail;
  final int? views;
  final String? source;
  final DateTime? publishedAt;
  final PublisherModel? publisherModel;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'html_body': htmlBody,
        'thumbnail': thumbnail,
        'views': views,
        'source': source,
        'published_at': publishedAt?.toIso8601String(),
        'publisher_id': publisherModel?.toMap(),
      };

  @override
  String toString() {
    return 'NewsModel($id, $title, $views, $publishedAt)';
  }
}

@embedded
class PublisherModel {
  PublisherModel({
    this.id,
    this.name,
    this.source,
    this.icon,
    this.newsApi,
    this.disable,
    this.createdAt,
    this.updatedAt,
  });

  factory PublisherModel.fromJson(String str) =>
      PublisherModel.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PublisherModel.fromMap(Map<String, dynamic> json) => PublisherModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        source: json['source'] as String?,
        icon: json['icon'] as String?,
        newsApi: json['news_api'] as bool?,
        disable: json['disable'] as bool?,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
  final int? id;
  final String? name;
  final String? source;
  final String? icon;
  final bool? newsApi;
  final bool? disable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'source': source,
        'icon': icon,
        'news_api': newsApi,
        'disable': disable,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
