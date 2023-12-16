import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/ads/native_ads_widgets.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/views/home/bloc/home_bloc.dart';
import 'package:mobile/widgets/news_card.dart';
import 'package:mobile/widgets/shimmer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _scrollController = ScrollController()..addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc()..add(const GetMoviesNews()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    title: const Text('The Cultural News'),
                    bottom: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      tabs: const <Widget>[
                        Tab(text: 'Movies'),
                        Tab(text: 'TV Series'),
                        Tab(text: 'Games'),
                        Tab(text: 'Anime'),
                        Tab(text: 'Comics & Books'),
                      ],
                      onTap: (int index) {
                        switch (index) {
                          case 0:
                            context.read<HomeBloc>().add(const GetMoviesNews());
                          case 1:
                            context.read<HomeBloc>().add(const GetTvNews());
                          case 2:
                            context.read<HomeBloc>().add(const GetGamingNews());
                          case 3:
                            context.read<HomeBloc>().add(const GetAnimeNews());
                          case 4:
                            context.read<HomeBloc>().add(const GetComicsNews());
                        }
                      },
                    ),
                  ),
                ],
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    movieNewsWidget(state),
                    tvNewsWidget(state, _scrollController),
                    gamingNewsWidget(state),
                    animeNewsWidget(state),
                    comicsNewsWidget(state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget tvNewsWidget(HomeState state, ScrollController controller) {
    if (state.tvStatus == TVStatus.loading || state.tvNewsList == null) {
      return const NewsListShimmerWidget();
    } else if (state.tvStatus == TVStatus.success && state.tvNewsList != null) {
      final newsList = state.tvNewsList;
      return NewsList(newsList: newsList);
    }

    return emptyWidget;
  }

  Widget comicsNewsWidget(HomeState state) {
    if (state.comicsStatus == ComicsStatus.loading ||
        state.comicsNewsList == null) {
      return const NewsListShimmerWidget();
    } else if (state.comicsStatus == ComicsStatus.success &&
        state.comicsNewsList != null) {
      final newsList = state.comicsNewsList;
      return NewsList(newsList: newsList);
    }

    return emptyWidget;
  }

  Widget gamingNewsWidget(HomeState state) {
    if (state.gameStatus == GameStatus.loading || state.gameStatus == null) {
      return const NewsListShimmerWidget();
    } else if (state.gameStatus == GameStatus.success &&
        state.gamesNewsList != null) {
      final newsList = state.gamesNewsList;
      return NewsList(newsList: newsList);
    }

    return emptyWidget;
  }

  Widget animeNewsWidget(HomeState state) {
    if (state.animeStatus == AnimeStatus.loading ||
        state.animeNewsList == null) {
      return const NewsListShimmerWidget();
    } else if (state.animeStatus == AnimeStatus.success &&
        state.animeNewsList != null) {
      final newsList = state.animeNewsList;
      return NewsList(newsList: newsList);
    }

    return emptyWidget;
  }

  Widget movieNewsWidget(HomeState state) {
    if (state.movieStatus == MovieStatus.loading ||
        state.moviesNewsList == null) {
      return const NewsListShimmerWidget();
    } else if (state.movieStatus == MovieStatus.success &&
        state.moviesNewsList != null) {
      final newsList = state.moviesNewsList;
      return NewsList(newsList: newsList);
    }

    return emptyWidget;
  }
}

class NewsList extends StatelessWidget {
  const NewsList({
    required this.newsList,
    this.scrollController,
    super.key,
  });

  final List<NewsModel>? newsList;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: horizontalPadding16 + verticalPadding12,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        if (index % 7 == 0) {
          return MediumNewsCard(news: newsList![index]);
        }

        if (index % 9 == 0) {
          return Column(
            children: [
              SmallNewsCard(
                news: newsList![index],
              ),
              HomePageNativeAds(
                key: Key(index.toString()),
              ),
            ],
          );
        }

        return SmallNewsCard(
          news: newsList![index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      shrinkWrap: true,
      itemCount: newsList!.length,
    );
  }
}
