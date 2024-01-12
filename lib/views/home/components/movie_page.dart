import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/views/home/bloc/home/home_bloc.dart';
import 'package:mobile/widgets/common.dart';
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
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(const GetMoviesNews()),
      child: BlocBuilder<HomeBloc, HomeState>(
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
              controller: _controller
                ..addListener(() {
                  if (_controller.position.pixels ==
                      _controller.position.maxScrollExtent) {
                    context
                        .read<HomeBloc>()
                        .add(const GetMoviesNews(loadMore: true));
                  }
                }),
            );
          } else {
            return emptyWidget;
          }
        },
      ),
    );
  }
}
