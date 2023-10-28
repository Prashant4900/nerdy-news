import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/ads/native_ads_widgets.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/state/blocs/news/news_bloc.dart';
import 'package:mobile/views/error/error_screen.dart';
import 'package:mobile/widgets/news_card.dart';
import 'package:mobile/widgets/shimmer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NewsBloc, NewsState>(
          bloc: context.read<NewsBloc>()..add(const NewsLoadEvent()),
          builder: (context, state) {
            if (state is NewsInitialState || state is NewsLoadingState) {
              return Column(
                children: [
                  AppBar(
                    title: Text(
                      'Nerdy News',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const NewsListShimmerWidget(),
                ],
              );
            } else if (state is NewsErrorState) {
              return MyErrorScreen(
                onTap: () {
                  context.read<NewsBloc>().add(const NewsLoadEvent());
                },
              );
            } else if (state is NewsLoadedState) {
              final newsList = state.newsList;

              return NestedScrollView(
                floatHeaderSlivers: true,
                controller: context.read<NewsBloc>().newsScrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      floating: true,
                      title: Text(
                        'Nerdy News',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ];
                },
                body: RefreshIndicator(
                  onRefresh: () async {
                    context.read<NewsBloc>().add(const NewsLoadEvent());
                  },
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final news = newsList[index];

                      if (index % 5 == 0) {
                        return Padding(
                          padding: horizontalPadding16 + verticalPadding4,
                          // child: MediumNewsCard(news: news),
                          child: SmallNewsCard(news: news),
                        );
                      } else if (index == 1) {
                        return Column(
                          children: [
                            Padding(
                              padding: horizontalPadding16 + verticalPadding4,
                              child: SmallNewsCard(news: news),
                            ),
                            HomePageNativeAds(
                              key: Key(index.toString()),
                            ),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: horizontalPadding16 + verticalPadding4,
                          child: SmallNewsCard(news: news),
                        );
                      }
                    },
                    separatorBuilder: (context, index) => const Divider(
                      endIndent: 16,
                      indent: 16,
                    ),
                    itemCount: newsList.length,
                  ),
                ),
              );
            } else {
              return Center(child: Text('We working on this $state'));
            }
          },
        ),
      ),
    );
  }
}