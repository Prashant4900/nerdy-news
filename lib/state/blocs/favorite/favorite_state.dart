part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState(this.newsList);

  final List<NewsModel> newsList;

  @override
  List<Object> get props => [newsList];
}

final class FavoriteInitial extends FavoriteState {
  const FavoriteInitial(super.newsList);
}

final class FavoriteLoading extends FavoriteState {
  const FavoriteLoading(super.newsList);
}

final class FavoriteLoaded extends FavoriteState {
  const FavoriteLoaded(super.newsList);
}

final class FavoriteDelete extends FavoriteState {
  const FavoriteDelete(super.newsList);
}

final class FavoriteError extends FavoriteState {
  const FavoriteError(super.newsList, {required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
