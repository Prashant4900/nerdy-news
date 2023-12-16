import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/models/publisher_model.dart';
import 'package:mobile/repositories/news_repository.dart';
import 'package:mobile/repositories/publisher_repository.dart';
import 'package:mobile/utils/supabase_config.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.initial()) {
    on<GetPublishersListEvent>(_getAllPublishers);
    on<GetNewsByPublisherEvent>(_getNewsByPublishers);
    on<GetNewsByQueryEvent>(_getNewsByQuery);
  }

  final client = getIt<SupabaseConfig>().client;
  final publisher = getIt<PublisherRepository>();
  final news = getIt<NewsRepository>();

  int newsPage = 0;

  FutureOr<void> _getAllPublishers(
    GetPublishersListEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final result = await publisher.getAllPublishers(client: client);
      emit(
        state.copyWith(
          status: SearchStatus.success,
          publishers: result,
        ),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          message: message,
        ),
      );
    }
  }

  FutureOr<void> _getNewsByPublishers(
    GetNewsByPublisherEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (!event.loadMore) {
      emit(state.copyWith(status: SearchStatus.loading));
    }
    try {
      if (event.loadMore) {
        newsPage += 10;

        final result = await news.getNewsByPublisher(
          client: client,
          publisherID: event.publisher.id!,
          page: newsPage + 1,
        );
        emit(
          state.copyWith(
            status: SearchStatus.success,
            newsList: [...state.newsList!, ...result!],
          ),
        );
      } else {
        final result = await news.getNewsByPublisher(
          client: client,
          publisherID: event.publisher.id!,
          page: newsPage,
        );
        emit(
          state.copyWith(
            status: SearchStatus.success,
            newsList: result,
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          message: message,
        ),
      );
    }
  }

  FutureOr<void> _getNewsByQuery(
    GetNewsByQueryEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final result = await news.getNewsByQuery(
        client: client,
        query: event.query,
      );
      emit(
        state.copyWith(
          status: SearchStatus.success,
          searchResult: result,
          isQueryExecuted: true,
        ),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          message: message,
        ),
      );
    }
  }
}
