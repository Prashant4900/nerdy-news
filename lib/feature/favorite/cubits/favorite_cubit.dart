// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:mobile/get_it.dart';
// import 'package:news/news.dart';

// part 'favorite_state.dart';

// class FavoriteCubit extends Cubit<FavoriteStates> {
//   FavoriteCubit() : super(const FavoriteInitial(bookmarked: false));

//   final news = getIt<NewsRepository>();

//   Future<void> getBookmarkState(NewsModel model) async {
//     final flag = await news.isItFavorite(model);

//     emit(FavoriteChanged(bookmarked: flag));
//   }

//   Future<void> setBookmarkState(NewsModel model) async {}
// }
