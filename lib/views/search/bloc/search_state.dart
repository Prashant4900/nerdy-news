part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState({
    required this.status,
    this.message,
    this.publishers,
    this.newsList,
    this.searchResult,
    this.isQueryExecuted = false,
  });

  final SearchStatus status;
  final String? message;
  final List<PublisherModel>? publishers;
  final List<NewsModel>? newsList;
  final List<NewsModel>? searchResult;
  final bool isQueryExecuted;

  // ignore: prefer_constructors_over_static_methods
  static SearchState initial() => const SearchState(
        status: SearchStatus.initial,
      );

  SearchState copyWith({
    SearchStatus? status,
    String? message,
    List<PublisherModel>? publishers,
    List<NewsModel>? newsList,
    List<NewsModel>? searchResult,
    bool isQueryExecuted = false,
  }) {
    return SearchState(
      status: status ?? this.status,
      message: message ?? this.message,
      publishers: publishers ?? this.publishers,
      newsList: newsList ?? this.newsList,
      searchResult: searchResult ?? this.searchResult,
      isQueryExecuted: isQueryExecuted,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        publishers,
        newsList,
        searchResult,
        isQueryExecuted,
      ];
}
