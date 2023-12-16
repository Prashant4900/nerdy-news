import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/models/publisher_model.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/views/search/bloc/search_bloc.dart';
import 'package:mobile/widgets/news_card.dart';
import 'package:mobile/widgets/shimmer.dart';
import 'package:shimmer/shimmer.dart';

final publisherList = [
  PublisherModel(
    name: 'The Hollywood Reporter',
    icon:
        'https://www.hollywoodreporter.com/wp-content/themes/vip/pmc-hollywoodreporter-2021/assets/app/icons/favicon.png',
  ),
  PublisherModel(
    name: 'Deadline',
    icon:
        'https://www.hollywoodreporter.com/wp-content/themes/vip/pmc-hollywoodreporter-2021/assets/app/icons/favicon.png',
  ),
  PublisherModel(
    name: 'Anime Explained',
    icon:
        'https://www.hollywoodreporter.com/wp-content/themes/vip/pmc-hollywoodreporter-2021/assets/app/icons/favicon.png',
  ),
  PublisherModel(
    name: 'Variety',
    icon:
        'https://www.hollywoodreporter.com/wp-content/themes/vip/pmc-hollywoodreporter-2021/assets/app/icons/favicon.png',
  ),
  PublisherModel(
    name: 'The Hollywood Reporter',
    icon:
        'https://www.hollywoodreporter.com/wp-content/themes/vip/pmc-hollywoodreporter-2021/assets/app/icons/favicon.png',
  ),
  PublisherModel(
    name: 'The Hollywood Reporter',
    icon:
        'https://www.hollywoodreporter.com/wp-content/themes/vip/pmc-hollywoodreporter-2021/assets/app/icons/favicon.png',
  ),
];

class MySearchScreen extends StatefulWidget {
  const MySearchScreen({super.key});

  @override
  State<MySearchScreen> createState() => _MySearchScreenState();
}

class _MySearchScreenState extends State<MySearchScreen> {
  List<NewsModel> _newsList = [];

  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = SearchController();
    super.initState();
  }

  @override
  void dispose() {
    _newsList.clear();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state.status == SearchStatus.success) {
          _newsList = state.searchResult ?? [];

          if (state.isQueryExecuted && _newsList.isEmpty) {
            Future.delayed(const Duration(milliseconds: 500), () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No Result Found'),
                ),
              );
            });
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: horizontalPadding16,
              child: Column(
                children: [
                  Padding(
                    padding: verticalPadding12,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.2),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          prefixIcon: Icon(CupertinoIcons.search, size: 20),
                        ),
                        onSubmitted: (String text) {
                          context
                              .read<SearchBloc>()
                              .add(GetNewsByQueryEvent(query: text));
                          _searchController.clear();
                        },
                      ),
                    ),
                  ),
                  _PublisherWidget(state: state),
                  verticalMargin12,
                  if (_newsList.isNotEmpty ||
                      state.status == SearchStatus.loading)
                    searchResult(context, state)
                  else
                    emptyWidget,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchResult(BuildContext context, SearchState state) {
    return state.status == SearchStatus.loading
        ? Column(
            children: [
              Row(
                children: [
                  Text(
                    'Search Results',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  horizontalMargin4,
                  const Icon(
                    CupertinoIcons.forward,
                    size: 20,
                  ),
                ],
              ),
              verticalMargin12,
              const SearchListShimmerWidget(),
            ],
          )
        : Column(
            children: [
              Row(
                children: [
                  Text(
                    'Search Results',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  horizontalMargin4,
                  const Icon(
                    CupertinoIcons.forward,
                    size: 20,
                  ),
                ],
              ),
              verticalMargin12,
              ListView.separated(
                itemCount: _newsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: bottomPadding16,
                itemBuilder: (BuildContext context, int index) {
                  return SmallNewsCard(news: _newsList[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            ],
          );
  }
}

class _PublisherWidget extends StatelessWidget {
  const _PublisherWidget({required this.state});

  final SearchState state;

  @override
  Widget build(BuildContext context) {
    if (state.status == SearchStatus.loading) {
      return Column(
        children: [
          Row(
            children: [
              Text(
                'Publishers',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              horizontalMargin4,
              const Icon(
                CupertinoIcons.forward,
                size: 20,
              ),
            ],
          ),
          verticalMargin16,
          SizedBox(
            height: 120,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: publisherList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: rightPadding12,
                  child: Shimmer.fromColors(
                    baseColor: getShimmerColor(context).$1,
                    highlightColor: getShimmerColor(context).$2,
                    child: MyPublisherIconWidget(
                      publisherModel: publisherList[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else if (state.status == SearchStatus.success) {
      final publishers = state.publishers;
      return Column(
        children: [
          Row(
            children: [
              Text(
                'Publishers',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              horizontalMargin4,
              const Icon(
                CupertinoIcons.forward,
                size: 20,
              ),
            ],
          ),
          verticalMargin16,
          SizedBox(
            height: 120,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: publishers!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: rightPadding12,
                  child: MyPublisherIconWidget(
                    publisherModel: publishers[index],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
    return emptyWidget;
  }
}

class MyPublisherIconWidget extends StatelessWidget {
  const MyPublisherIconWidget({
    required this.publisherModel,
    super.key,
  });

  final PublisherModel publisherModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              MyRoutes.publisherScreen,
              arguments: PublisherArguments(model: publisherModel),
            );
          },
          child: Container(
            width: 55,
            height: 55,
            padding: allPadding4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              publisherModel.icon!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        verticalMargin8,
        SizedBox(
          width: 80,
          child: Text(
            publisherModel.name!,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
