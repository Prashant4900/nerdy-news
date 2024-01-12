import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/repositories/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState.initial()) {
    on<GetAllFavorite>(_allAllFavorite);
    on<IsFavorite>(_isFavorite);
    on<AddTOFavorite>(_addToFavorite);
    on<DeleteFavorite>(_deleteFavorite);
  }

  final favorite = getIt<FavoriteRepository>();

  FutureOr<void> _deleteFavorite(
    DeleteFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(const FavoriteState(status: FavoriteStatus.loading));
    try {
      final flag = await favorite.deleteFavorite(event.news);
      if (flag) {
        final result = await favorite.getAllFavorite();

        emit(FavoriteState(status: FavoriteStatus.success, newsList: result));
      } else {
        final result = await favorite.getAllFavorite();

        emit(
          FavoriteState(
            isFavorite: true,
            status: FavoriteStatus.success,
            message: 'Something went wrong.',
            newsList: result,
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(
        FavoriteState(
          status: FavoriteStatus.failure,
          message: message,
          isFavorite: true,
        ),
      );
    }
  }

  FutureOr<void> _addToFavorite(
    AddTOFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(const FavoriteState(status: FavoriteStatus.loading));
    try {
      await favorite.insertIntoFavorite(event.news);
      final result = await favorite.getAllFavorite();

      emit(
        FavoriteState(
          status: FavoriteStatus.success,
          isFavorite: true,
          newsList: result,
        ),
      );
    } catch (e) {
      final message = e.toString();
      emit(FavoriteState(status: FavoriteStatus.failure, message: message));
    }
  }

  FutureOr<void> _isFavorite(
    IsFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(const FavoriteState(status: FavoriteStatus.loading));
    try {
      final flag = await favorite.isItFavorite(event.news);
      if (flag) {
        final result = await favorite.getAllFavorite();

        emit(
          FavoriteState(
            status: FavoriteStatus.success,
            isFavorite: true,
            newsList: result,
          ),
        );
      } else {
        final result = await favorite.getAllFavorite();

        emit(
          FavoriteState(
            status: FavoriteStatus.success,
            message: 'Something went wrong.',
            newsList: result,
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(FavoriteState(status: FavoriteStatus.failure, message: message));
    }
  }

  FutureOr<void> _allAllFavorite(
    GetAllFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(const FavoriteState(status: FavoriteStatus.loading));
    try {
      final result = await favorite.getAllFavorite();
      emit(
        FavoriteState(status: FavoriteStatus.success, newsList: result),
      );
    } catch (e) {
      final message = e.toString();
      emit(FavoriteState(status: FavoriteStatus.failure, message: message));
    }
  }
}
