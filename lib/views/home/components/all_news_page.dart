import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/views/home/bloc/home_bloc.dart';
import 'package:mobile/views/home/common.dart';
import 'package:mobile/widgets/shimmer.dart';

class AllNewsPage extends StatefulWidget {
  const AllNewsPage({super.key});

  @override
  State<AllNewsPage> createState() => _AllNewsPageState();
}

class _AllNewsPageState extends State<AllNewsPage> {
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
      create: (context) => HomeBloc()..add(const GetAllNews()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.allNewsStatus == AllNewsStatus.loading) {
            return const NewsListShimmerWidget();
          } else if (state.allNewsStatus == AllNewsStatus.failure) {
            return Center(
              child: Text(state.message!),
            );
          } else if (state.allNewsStatus == AllNewsStatus.success) {
            final newsList = state.allNewsList;

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
                        .add(const GetAllNews(loadMore: true));
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
