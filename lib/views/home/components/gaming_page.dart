import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/views/home/bloc/home_bloc.dart';
import 'package:mobile/views/home/common.dart';

class GamingPage extends StatefulWidget {
  const GamingPage({super.key});

  @override
  State<GamingPage> createState() => _GamingPageState();
}

class _GamingPageState extends State<GamingPage> {
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
      create: (context) => HomeBloc()..add(const GetGamingNews()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.gameStatus == GameStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.gameStatus == GameStatus.failure) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else if (state.gameStatus == GameStatus.success) {
            final newsList = state.gamesNewsList;

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
                    context.read<HomeBloc>().add(
                          const GetGamingNews(loadMore: true),
                        );
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
