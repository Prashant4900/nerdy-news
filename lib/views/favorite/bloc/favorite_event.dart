part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

final class GetAllFavorite extends FavoriteEvent {}

final class IsFavorite extends FavoriteEvent {
  const IsFavorite({required this.news});

  final NewsModel news;

  @override
  List<Object> get props => [news];
}

final class AddTOFavorite extends FavoriteEvent {
  const AddTOFavorite({required this.news});

  final NewsModel news;

  @override
  List<Object> get props => [news];
}

final class DeleteFavorite extends FavoriteEvent {
  const DeleteFavorite({required this.news});

  final NewsModel news;

  @override
  List<Object> get props => [news];
}
