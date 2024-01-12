import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/views/favorite/bloc/favorite_bloc.dart';
import 'package:mobile/widgets/news_card.dart';

class MyBookmarkPage extends StatelessWidget {
  const MyBookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Saved Articles',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          bloc: context.read<FavoriteBloc>()..add(GetAllFavorite()),
          builder: (context, state) {
            if (state.status == FavoriteStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == FavoriteStatus.failure) {
              return Center(child: Text(state.message!));
            } else if (state.status == FavoriteStatus.success) {
              final articles = state.newsList;
              if (articles == null || articles.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: const Center(
                    child: EmptyArticleCard(
                      label: 'Saved Articles',
                      description:
                          '''Saved articles are stored here. Tap to icon on any article to add it to your collection.''',
                    ),
                  ),
                );
              }

              return ListView.separated(
                itemCount: articles.length,
                shrinkWrap: true,
                padding: allPadding16,
                itemBuilder: (BuildContext context, int index) {
                  final news = articles[index];
                  return Dismissible(
                    key: Key(news.id!.toString()),
                    confirmDismiss: (direction) async {
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Are you sure you wish to delete this article?',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            content: ListView(
                              shrinkWrap: true,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: news.thumbnail!,
                                  ),
                                ),
                                verticalMargin8,
                                Text(
                                  news.title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<FavoriteBloc>()
                                      .add(DeleteFavorite(news: news));
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text('DELETE'),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('CANCEL'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: SmallNewsCard(news: news),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              );
            } else {
              return emptyWidget;
            }
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
