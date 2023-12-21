part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAnimeNews extends HomeEvent {
  const GetAnimeNews({
    this.loadMore = false,
  });

  final bool loadMore;

  @override
  List<Object> get props => [super.props, loadMore];
}

class GetAllNews extends HomeEvent {
  const GetAllNews({
    this.loadMore = false,
  });

  final bool loadMore;

  @override
  List<Object> get props => [super.props, loadMore];
}

class GetMoviesNews extends HomeEvent {
  const GetMoviesNews({
    this.loadMore = false,
  });

  final bool loadMore;

  @override
  List<Object> get props => [super.props, loadMore];
}

class GetTvNews extends HomeEvent {
  const GetTvNews({
    this.loadMore = false,
  });

  final bool loadMore;

  @override
  List<Object> get props => [super.props, loadMore];
}

class GetGamingNews extends HomeEvent {
  const GetGamingNews({
    this.loadMore = false,
  });

  final bool loadMore;

  @override
  List<Object> get props => [super.props, loadMore];
}

class GetComicsNews extends HomeEvent {
  const GetComicsNews({
    this.loadMore = false,
  });

  final bool loadMore;

  @override
  List<Object> get props => [super.props, loadMore];
}
