part of 'favorite_bloc.dart';

enum FavoriteStatus { initial, loading, success, failure }

class FavoriteState extends Equatable {
  const FavoriteState({
    required this.status,
    this.message,
    this.newsList,
    this.isFavorite = false,
  });

  final FavoriteStatus status;
  final String? message;
  final List<NewsModel>? newsList;
  final bool isFavorite;

  // ignore: prefer_constructors_over_static_methods
  static FavoriteState initial() => const FavoriteState(
        status: FavoriteStatus.initial,
      );

  FavoriteState copyWith({
    FavoriteStatus? status,
    String? message,
    List<NewsModel>? newsList,
    bool isFavorite = false,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      message: message ?? this.message,
      newsList: newsList ?? this.newsList,
      isFavorite: isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        newsList,
        isFavorite,
      ];
}
