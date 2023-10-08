part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

final class NewsLoadEvent extends NewsEvent {
  const NewsLoadEvent();
}

final class NewsLoadMoreEvent extends NewsEvent {
  const NewsLoadMoreEvent();
}
