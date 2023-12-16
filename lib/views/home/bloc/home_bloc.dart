import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/repositories/news_repository.dart';
import 'package:mobile/utils/supabase_config.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<GetAnimeNews>(_getAnimeNews);
    on<GetMoviesNews>(_getMovieNews);
    on<GetComicsNews>(_getComicsNews);
    on<GetGamingNews>(_getGamingNews);
    on<GetTvNews>(_getTVNews);
  }

  final client = getIt<SupabaseConfig>().client;
  final news = getIt<NewsRepository>();
  int newsPage = 0;
  int _animeNewsPage = 0;
  int _movieNewsPage = 0;
  int _tvNewsPage = 0;
  int _gamingNewsPage = 0;
  int _comicsNewsPage = 0;

  FutureOr<void> _getAnimeNews(
    GetAnimeNews event,
    Emitter<HomeState> emit,
  ) async {
    if (!event.loadMore) {
      emit(state.copyWith(animeStatus: AnimeStatus.loading));
    }
    try {
      if (event.loadMore) {
        _animeNewsPage += 10;
        final result = await news.getNewsByCategory(
          client: client,
          categoryID: 1,
          page: _animeNewsPage + 1,
        );
        emit(
          state.copyWith(
            animeStatus: AnimeStatus.success,
            animeNewsList: [...state.animeNewsList!, ...result!],
          ),
        );
      } else {
        final result = await news.getNewsByCategory(
          client: client,
          categoryID: 1,
        );
        emit(
          state.copyWith(
            animeStatus: AnimeStatus.success,
            animeNewsList: result,
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          animeStatus: AnimeStatus.failure,
          message: message,
        ),
      );
    }
  }

  FutureOr<void> _getMovieNews(
    GetMoviesNews event,
    Emitter<HomeState> emit,
  ) async {
    if (!event.loadMore) {
      emit(state.copyWith(movieStatus: MovieStatus.loading));
    }
    try {
      if (event.loadMore) {
        _movieNewsPage += 10;
        final result = await news.getNewsByCategory(
          client: client,
          categoryID: 4,
          page: _movieNewsPage + 1,
        );
        emit(
          state.copyWith(
            movieStatus: MovieStatus.success,
            moviesNewsList: [...state.moviesNewsList!, ...result!],
          ),
        );
      } else {
        final result = await news.getNewsByCategory(
          client: client,
          categoryID: 4,
        );
        emit(
          state.copyWith(
            movieStatus: MovieStatus.success,
            moviesNewsList: result,
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          movieStatus: MovieStatus.failure,
          message: message,
        ),
      );
    }
  }

  FutureOr<void> _getTVNews(GetTvNews event, Emitter<HomeState> emit) async {
    if (!event.loadMore) {
      emit(state.copyWith(tvStatus: TVStatus.loading));
    }
    try {
      if (event.loadMore) {
        _tvNewsPage += 10;
        final result = await news.getNewsByCategory(
          client: client,
          categoryID: 5,
          page: _tvNewsPage + 1,
        );
        emit(
          state.copyWith(
            tvStatus: TVStatus.success,
            tvNewsList: [...state.tvNewsList!, ...result!],
          ),
        );
      } else {
        final result = await news.getNewsByCategory(
          client: client,
          categoryID: 5,
        );
        emit(
          state.copyWith(
            tvStatus: TVStatus.success,
            tvNewsList: result,
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          tvStatus: TVStatus.failure,
          message: message,
        ),
      );
    }
  }

  FutureOr<void> _getGamingNews(
    GetGamingNews event,
    Emitter<HomeState> emit,
  ) async {
    if (!event.loadMore) {
      emit(state.copyWith(gameStatus: GameStatus.loading));
    }
    try {
      if (event.loadMore) {
        _gamingNewsPage += 10;
        final result = await news.getNewsByCategory(
          client: client,
          categoryID: 3,
          page: _gamingNewsPage + 1,
        );
        emit(
          state.copyWith(
            gameStatus: GameStatus.success,
            gamesNewsList: [...state.gamesNewsList!, ...result!],
          ),
        );
      } else {
        final result = await news.getNewsByCategory(
          client: client,
          categoryID: 3,
        );
        emit(
          state.copyWith(
            gameStatus: GameStatus.success,
            gamesNewsList: result,
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          gameStatus: GameStatus.failure,
          message: message,
        ),
      );
    }
  }

  FutureOr<void> _getComicsNews(
    GetComicsNews event,
    Emitter<HomeState> emit,
  ) async {
    if (!event.loadMore) {
      emit(state.copyWith(comicsStatus: ComicsStatus.loading));
    }
    try {
      if (event.loadMore) {
        _comicsNewsPage += 10;
        final result = await news.getNewsByCategory(
          client: client,
          categoryID: 2,
          page: _comicsNewsPage + 1,
        );
        emit(
          state.copyWith(
            comicsStatus: ComicsStatus.success,
            comicsNewsList: [...state.comicsNewsList!, ...result!],
          ),
        );
      } else {
        final result = await news.getNewsByCategory(
          client: client,
          categoryID: 2,
        );
        emit(
          state.copyWith(
            comicsStatus: ComicsStatus.success,
            comicsNewsList: result,
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          comicsStatus: ComicsStatus.failure,
          message: message,
        ),
      );
    }
  }
}
