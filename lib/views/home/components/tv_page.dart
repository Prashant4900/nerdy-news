import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/views/home/bloc/home/home_bloc.dart';
import 'package:mobile/widgets/common.dart';
import 'package:mobile/widgets/shimmer.dart';

class TVPage extends StatefulWidget {
  const TVPage({super.key});

  @override
  State<TVPage> createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> {
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
      create: (context) => HomeBloc()..add(const GetTvNews()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.tvStatus == TVStatus.loading) {
            return const NewsListShimmerWidget();
          } else if (state.tvStatus == TVStatus.failure) {
            return Center(
              child: Text(state.message!),
            );
          } else if (state.tvStatus == TVStatus.success) {
            final newsList = state.tvNewsList;

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
                        .add(const GetTvNews(loadMore: true));
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
