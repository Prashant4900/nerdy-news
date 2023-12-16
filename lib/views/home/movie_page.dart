import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/views/home/bloc/home_bloc.dart';
import 'package:mobile/views/home/common.dart';
import 'package:mobile/widgets/shimmer.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          context.read<HomeBloc>().add(const GetMoviesNews(loadMore: true));
        }
      });
    context.read<HomeBloc>().add(const GetMoviesNews());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.movieStatus == MovieStatus.loading) {
          return const NewsListShimmerWidget();
        } else if (state.movieStatus == MovieStatus.failure) {
          return Center(
            child: Text(state.message!),
          );
        } else if (state.movieStatus == MovieStatus.success) {
          final newsList = state.moviesNewsList;

          if (newsList == null) {
            return const Center(
              child: Text('Oops Nothing here.'),
            );
          }
          return NewsList(
            newsList: newsList,
            controller: _controller,
          );
        } else {
          return emptyWidget;
        }
      },
    );
  }
}
