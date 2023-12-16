import 'package:flutter/material.dart';
import 'package:mobile/ads/native_ads_widgets.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/widgets/news_card.dart';

class NewsList extends StatelessWidget {
  const NewsList({
    required this.newsList,
    this.controller,
    super.key,
  });

  final List<NewsModel>? newsList;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: horizontalPadding16 + verticalPadding12,
      controller: controller,
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
