part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetPublishersListEvent extends SearchEvent {
  const GetPublishersListEvent();

  @override
  List<Object> get props => [super.props];
}

class GetNewsByPublisherEvent extends SearchEvent {
  const GetNewsByPublisherEvent({
    required this.publisher,
    this.loadMore = false,
  });

  final PublisherModel publisher;
  final bool loadMore;

  @override
  List<Object> get props => [super.props, publisher, loadMore];
}

class GetNewsByQueryEvent extends SearchEvent {
  const GetNewsByQueryEvent({
    required this.query,
    this.loadMore = false,
  });

  final String query;
  final bool loadMore;

  @override
  List<Object> get props => [super.props, query, loadMore];
}
