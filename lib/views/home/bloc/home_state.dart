part of 'home_bloc.dart';

enum MovieStatus { initial, loading, success, failure }

enum AnimeStatus { initial, loading, success, failure }

enum TVStatus { initial, loading, success, failure }

enum GameStatus { initial, loading, success, failure }

enum ComicsStatus { initial, loading, success, failure }

enum AllNewsStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.movieStatus,
    this.animeStatus,
    this.gameStatus,
    this.tvStatus,
    this.comicsStatus,
    this.allNewsStatus,
    this.animeNewsList,
    this.gamesNewsList,
    this.moviesNewsList,
    this.tvNewsList,
    this.comicsNewsList,
    this.allNewsList,
    this.message,
  });

  final MovieStatus? movieStatus;
  final AnimeStatus? animeStatus;
  final GameStatus? gameStatus;
  final TVStatus? tvStatus;
  final ComicsStatus? comicsStatus;
  final AllNewsStatus? allNewsStatus;
  final String? message;
  final List<NewsModel>? animeNewsList;
  final List<NewsModel>? allNewsList;
  final List<NewsModel>? gamesNewsList;
  final List<NewsModel>? tvNewsList;
  final List<NewsModel>? moviesNewsList;
  final List<NewsModel>? comicsNewsList;

  static HomeState initial() => const HomeState(
        movieStatus: MovieStatus.initial,
        animeStatus: AnimeStatus.initial,
        gameStatus: GameStatus.initial,
        tvStatus: TVStatus.initial,
        comicsStatus: ComicsStatus.initial,
        allNewsStatus: AllNewsStatus.initial,
      );

  HomeState copyWith({
    MovieStatus? movieStatus,
    AnimeStatus? animeStatus,
    GameStatus? gameStatus,
    AllNewsStatus? allNewsStatus,
    TVStatus? tvStatus,
    ComicsStatus? comicsStatus,
    List<NewsModel>? animeNewsList,
    List<NewsModel>? gamesNewsList,
    List<NewsModel>? tvNewsList,
    List<NewsModel>? moviesNewsList,
    List<NewsModel>? comicsNewsList,
    List<NewsModel>? allNewsList,
    String? message,
  }) {
    return HomeState(
      movieStatus: movieStatus ?? this.movieStatus,
      animeStatus: animeStatus ?? this.animeStatus,
      gameStatus: gameStatus ?? this.gameStatus,
      allNewsStatus: allNewsStatus ?? this.allNewsStatus,
      tvStatus: tvStatus ?? this.tvStatus,
      comicsStatus: comicsStatus ?? this.comicsStatus,
      animeNewsList: animeNewsList ?? this.animeNewsList,
      allNewsList: allNewsList ?? this.allNewsList,
      gamesNewsList: gamesNewsList ?? this.gamesNewsList,
      comicsNewsList: comicsNewsList ?? this.comicsNewsList,
      tvNewsList: tvNewsList ?? this.tvNewsList,
      message: message ?? this.message,
      moviesNewsList: moviesNewsList ?? this.moviesNewsList,
    );
  }

  @override
  List<Object?> get props => [
        movieStatus,
        animeStatus,
        gameStatus,
        tvStatus,
        comicsStatus,
        animeNewsList,
        gamesNewsList,
        moviesNewsList,
        comicsNewsList,
        allNewsStatus,
        allNewsList,
        tvNewsList,
        message,
      ];
}
