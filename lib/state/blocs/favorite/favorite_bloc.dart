import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/get_it.dart';
import 'package:news/news.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteInitial([])) {
    on<GetAllFavoriteEvent>(_getAllNews);
    on<AddTOFavoriteEvent>(_addIntoFavorite);
    on<DeleteFavoriteEvent>(_deleteFavorite);
  }

  final news = getIt<NewsRepository>();

  FutureOr<void> _getAllNews(
    GetAllFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(const FavoriteLoading([]));
    try {
      final result = await news.getAllFavorite();
      emit(FavoriteLoaded(result));
    } catch (e) {
      final message = e.toString();
      emit(FavoriteError(const [], message: message));
    }
  }

  FutureOr<void> _addIntoFavorite(
    AddTOFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(const FavoriteLoading([]));
    try {
      await news.insertIntoFavorite(event.news);
      final result = await news.getAllFavorite();
      emit(FavoriteLoaded(result));
    } catch (e) {
      final message = e.toString();
      emit(FavoriteError(const [], message: message));
    }
  }

  FutureOr<void> _deleteFavorite(
    DeleteFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(const FavoriteLoading([]));
    try {
      await news.deleteFavorite(event.news);
      final result = await news.getAllFavorite();
      emit(FavoriteLoaded(result));
    } catch (e) {
      final message = e.toString();
      emit(FavoriteError(const [], message: message));
    }
  }
}
