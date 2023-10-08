part of 'news_bloc.dart';

@immutable
sealed class NewsState extends Equatable {
  const NewsState(this.newsList);
  final List<NewsModel> newsList;

  @override
  List<Object> get props => [newsList];
}

@immutable
final class NewsInitialState extends NewsState {
  const NewsInitialState(super.newsList);
}

@immutable
final class NewsLoadingState extends NewsState {
  const NewsLoadingState(super.newsList);
}

class NewsLoadedState extends NewsState {
  const NewsLoadedState(super.newsList);
}

class NewsErrorState extends NewsState {
  const NewsErrorState(
    super.newsList, {
    required this.message,
  });
  final String message;
  @override
  List<Object> get props => [message, super.newsList];
}
