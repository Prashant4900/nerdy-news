import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/state/providers/favorite_state/favorite_state_provider.dart';
import 'package:mobile/utils/date_time.dart';
import 'package:mobile/utils/time_to_read.dart';
import 'package:mobile/views/home/bottom_sheet.dart';
import 'package:news/news.dart';
import 'package:provider/provider.dart';

void _moveToNewsDetail(BuildContext context, NewsModel news) {
  Provider.of<FavoriteStateProvider>(context, listen: false).isBookmarked(news);
  Navigator.pushNamed(
    context,
    MyRoutes.newsDetailScreen,
    arguments: NewsDetailArguments(newsModel: news),
  );
}

class SmallNewsCard extends StatelessWidget {
  const SmallNewsCard({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _moveToNewsDetail(context, news),
      onLongPress: () => newsButtonSheet(context, news),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      foregroundImage: NetworkImage(news.publisherModel!.icon!),
                      radius: 7,
                    ),
                    horizontalMargin4,
                    Text(
                      news.publisherModel!.name!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                verticalMargin12,
                Text(
                  news.title!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                verticalMargin8,
                Row(
                  children: [
                    Text(
                      timeToRead(news.htmlBody!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    horizontalMargin4,
                    Text(
                      '•',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    horizontalMargin4,
                    Text(
                      getTimeAgo(news.publishedAt!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          horizontalMargin12,
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              news.thumbnail!,
              width: 85,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class MediumNewsCard extends StatelessWidget {
  const MediumNewsCard({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _moveToNewsDetail(context, news),
      onLongPress: () => newsButtonSheet(context, news),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: news.thumbnail!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          verticalMargin12,
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: news.publisherModel!.icon!,
                  width: 16,
                  height: 16,
                ),
              ),
              horizontalMargin12,
              Text(
                news.publisherModel!.name!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              horizontalMargin4,
              Text(
                '•',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              horizontalMargin4,
              Text(
                getTimeAgo(news.publishedAt!),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          verticalMargin12,
          Text(
            news.title!,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          verticalMargin4,
          Text(
            timeToRead(news.htmlBody!),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          verticalMargin8,
        ],
      ),
    );
  }
}

class LargeNewsCard extends StatelessWidget {
  const LargeNewsCard({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _moveToNewsDetail(context, news),
      onLongPress: () => newsButtonSheet(context, news),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(imageUrl: news.thumbnail!),
          ),
          verticalMargin12,
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: news.publisherModel!.icon!,
                  width: 16,
                  height: 16,
                ),
              ),
              horizontalMargin12,
              Text(
                news.publisherModel!.name!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              horizontalMargin4,
              Text(
                '•',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              horizontalMargin4,
              Text(
                getTimeAgo(news.publishedAt!),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          verticalMargin12,
          Text(
            news.title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          verticalMargin8,
          Text(
            news.description!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.justify,
          ),
          verticalMargin8,
        ],
      ),
    );
  }
}
