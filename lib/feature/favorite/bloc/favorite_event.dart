part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

final class GetAllFavoriteEvent extends FavoriteEvent {}

final class IsFavoriteEvent extends FavoriteEvent {
  const IsFavoriteEvent({required this.news});

  final NewsModel news;

  @override
  List<Object> get props => [news];
}

final class AddTOFavoriteEvent extends FavoriteEvent {
  const AddTOFavoriteEvent({required this.news});

  final NewsModel news;

  @override
  List<Object> get props => [news];
}

final class DeleteFavoriteEvent extends FavoriteEvent {
  const DeleteFavoriteEvent({required this.news});

  final NewsModel news;

  @override
  List<Object> get props => [news];
}
