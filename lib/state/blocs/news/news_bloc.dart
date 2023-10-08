import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/services/supabase_config.dart';
import 'package:news/news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsInitialState([])) {
    newsScrollController.addListener(() {
      add(const NewsLoadMoreEvent());
    });
    on<NewsLoadEvent>(_getAllNews);
    on<NewsLoadMoreEvent>(_loadMoreNews);
  }

  int newsPage = 0;
  ScrollController newsScrollController = ScrollController();

  final client = getIt<SupabaseConfig>().client;
  final news = getIt<NewsRepository>();

  FutureOr<void> _getAllNews(
    NewsLoadEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(const NewsLoadingState([]));
    try {
      final result = await news.getAllNews(
        client: client,
        page: newsPage,
      );
      emit(NewsLoadedState(result!));
    } catch (e) {
      final message = e.toString();
      emit(NewsErrorState(message: message, state.newsList));
    }
  }

  FutureOr<void> _loadMoreNews(
    NewsLoadMoreEvent event,
    Emitter<NewsState> emit,
  ) async {
    try {
      if (newsScrollController.position.pixels ==
          newsScrollController.position.maxScrollExtent) {
        newsPage += 10;
        final result = await news.getAllNews(
          client: client,
          page: newsPage + 1,
        );
        emit(NewsLoadedState([...state.newsList, ...result!]));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
