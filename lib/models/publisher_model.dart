import 'dart:convert';

class PublisherModel {
  PublisherModel({
    this.id,
    this.name,
    this.source,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.provider,
    this.enable,
  });

  factory PublisherModel.fromJson(String str) =>
      PublisherModel.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PublisherModel.fromMap(Map<String, dynamic> json) => PublisherModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        source: json['source'] as String?,
        icon: json['icon'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        provider: json['provider'] as String?,
        enable: json['enable'] as bool?,
      );
  final int? id;
  final String? name;
  final String? source;
  final String? icon;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? provider;
  final bool? enable;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'source': source,
        'icon': icon,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'provider': provider,
        'enable': enable,
      };
}
