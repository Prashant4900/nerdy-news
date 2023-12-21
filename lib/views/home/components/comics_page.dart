import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/views/home/bloc/home_bloc.dart';
import 'package:mobile/views/home/common.dart';

class ComicsPage extends StatefulWidget {
  const ComicsPage({super.key});

  @override
  State<ComicsPage> createState() => _ComicsPageState();
}

class _ComicsPageState extends State<ComicsPage> {
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
      create: (context) => HomeBloc()..add(const GetComicsNews()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.comicsStatus == ComicsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.comicsStatus == ComicsStatus.failure) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else if (state.comicsStatus == ComicsStatus.success) {
            final newsList = state.comicsNewsList;

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
                          const GetComicsNews(loadMore: true),
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
