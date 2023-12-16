import 'package:flutter/material.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/repositories/news_repository.dart';

class FavoriteStateProvider extends ChangeNotifier {
  final news = getIt<NewsRepository>();

  final bool _isFavorite = false;

  Future<bool> get isFavorite async => _isFavorite;

  Future<void> isBookmarked(NewsModel model) async {
    // final flag = await news.isItFavorite(model);
    // _isFavorite = flag;
    notifyListeners();
  }
}
