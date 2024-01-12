import 'dart:convert';

class NewsSummaryModel {
  NewsSummaryModel({
    this.english,
    this.hinglish,
  });

  factory NewsSummaryModel.fromJson(String str) =>
      NewsSummaryModel.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NewsSummaryModel.fromMap(Map<String, dynamic> json) =>
      NewsSummaryModel(
        english: Nglish.fromMap(json['english'] as Map<String, dynamic>),
        hinglish: Nglish.fromMap(json['hinglish'] as Map<String, dynamic>),
      );
  final Nglish? english;
  final Nglish? hinglish;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'english': english?.toMap(),
        'hinglish': hinglish?.toMap(),
      };
}

class Nglish {
  Nglish({
    this.title,
    this.description,
    this.summarize,
  });

  factory Nglish.fromJson(String str) =>
      Nglish.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Nglish.fromMap(Map<String, dynamic> json) => Nglish(
        title: json['title'] as String,
        description: json['description'] as String,
        summarize: json['summarize'] as String,
      );
  final String? title;
  final String? description;
  final String? summarize;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'summarize': summarize,
      };
}
