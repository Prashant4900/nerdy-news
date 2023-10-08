import 'dart:convert';

class FeedbackModel {
  FeedbackModel({
    this.id,
    this.title,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.userId,
    this.buildNo,
  });

  factory FeedbackModel.fromRawJson(String str) => FeedbackModel.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        message: json['message'] as String?,
        buildNo: json['build_no'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        image: json['image'] as String?,
        userId: json['user_id'] as String?,
      );
  int? id;
  String? title;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? image;
  String? userId;
  String? buildNo;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'title': title,
        'message': message,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'image': image,
        'user_id': userId,
        'build_no': buildNo,
      };
}
