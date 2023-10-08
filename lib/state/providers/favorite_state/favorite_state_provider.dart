import 'package:flutter/material.dart';
import 'package:mobile/get_it.dart';
import 'package:news/news.dart';

class FavoriteStateProvider extends ChangeNotifier {
  final news = getIt<NewsRepository>();

  bool _isFavorite = false;

  Future<bool> get isFavorite async => _isFavorite;

  Future<void> isBookmarked(NewsModel model) async {
    final flag = await news.isItFavorite(model);
    _isFavorite = flag;
    notifyListeners();
  }
}
