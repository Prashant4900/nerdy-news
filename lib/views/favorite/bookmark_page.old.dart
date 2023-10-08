import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/extension/string.dart';
import 'package:mobile/state/blocs/favorite/favorite_bloc.dart';
import 'package:mobile/state/providers/favorite_state/favorite_state_provider.dart';
import 'package:mobile/utils/date_time.dart';
import 'package:mobile/views/home/news_details_screen.dart';
import 'package:provider/provider.dart';

class MyBookmarkPage extends StatelessWidget {
  const MyBookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          bloc: context.read<FavoriteBloc>()..add(GetAllFavoriteEvent()),
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      floating: true,
                      title: Text(
                        'Saved Article',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ];
                },
                body: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is FavoriteError) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      floating: true,
                      title: Text(
                        'Saved Article',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ];
                },
                body: Center(child: Text(state.message)),
              );
            } else if (state is FavoriteLoaded) {
              if (state.newsList.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .9,
                  child: const Center(
                    child: EmptyArticleCard(
                      label: 'Saved Articles',
                      description:
                          '''Saved articles are stored here. Tap to icon on any article to add it to your collection.''',
                    ),
                  ),
                );
              }
              return NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      floating: true,
                      title: Text(
                        'Saved Article',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ];
                },
                body: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.newsList.length,
                  padding: verticalPadding12,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final news = state.newsList[index];
                    final publisher = state.newsList[index].publisherModel;

                    return Dismissible(
                      key: Key(news.id!.toString()),
                      onDismissed: (direction) {
                        context
                            .read<FavoriteBloc>()
                            .add(DeleteFavoriteEvent(news: news));
                        const snackBar = SnackBar(
                          content: Text('News Deleted'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: InkWell(
                        onTap: () {
                          Provider.of<FavoriteStateProvider>(
                            context,
                            listen: false,
                          ).isBookmarked(news);
                          Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (context) => NewsDetailScreen(
                                news: news,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: horizontalPadding16,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      news.title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    verticalMargin12,
                                    Text(
                                      '''${publisher!.name!.title}\t•\t${getTimeAgo(news.publishedAt!)}''',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              horizontalMargin12,
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  news.thumbnail!,
                                  fit: BoxFit.cover,
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    indent: 16,
                    endIndent: 16,
                  ),
                ),
              );
            }
            return emptyWidget;
          },
        ),
      ),
    );
  }
}

@immutable
class EmptyArticleCard extends StatelessWidget {
  const EmptyArticleCard({
    required this.label,
    required this.description,
    super.key,
  });

  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CupertinoIcons.bookmark),
              horizontalMargin12,
              Text(
                label,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          verticalMargin8,
          Padding(
            padding: horizontalPadding24,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
