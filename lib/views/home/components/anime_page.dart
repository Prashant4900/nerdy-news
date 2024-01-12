import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/views/home/bloc/home/home_bloc.dart';
import 'package:mobile/widgets/common.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(const GetAnimeNews()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.animeStatus == AnimeStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.animeStatus == AnimeStatus.failure) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else if (state.animeStatus == AnimeStatus.success) {
            final newsList = state.animeNewsList;

            if (newsList == null) {
              return const Center(
                child: Text('Oops Nothing here.'),
              );
            }
            return NewsList(
              newsList: newsList,
              controller: _scrollController
                ..addListener(() {
                  if (_scrollController.position.pixels ==
                      _scrollController.position.maxScrollExtent) {
                    context
                        .read<HomeBloc>()
                        .add(const GetAnimeNews(loadMore: true));
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
