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
          CachedNetworkImage(
            imageUrl: news.thumbnail!,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: 85,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return emptyWidget;
            },
          ),
        ],
      ),
    );
  }
}

class MediumNewsCard extends StatefulWidget {
  const MediumNewsCard({required this.news, super.key});

  final NewsModel news;

  @override
  State<MediumNewsCard> createState() => _MediumNewsCardState();
}

class _MediumNewsCardState extends State<MediumNewsCard> {
  bool _isImageLoadFailed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _moveToNewsDetail(context, widget.news),
      onLongPress: () => newsButtonSheet(context, widget.news),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: widget.news.thumbnail!,
            imageBuilder: (context, imageProvider) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            errorListener: (obj) {
              setState(() {
                _isImageLoadFailed = true;
              });
            },
            errorWidget: (context, url, error) {
              return emptyWidget;
            },
          ),
          verticalMargin12,
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: widget.news.publisherModel!.icon!,
                  width: 16,
                  height: 16,
                ),
              ),
              horizontalMargin12,
              Text(
                widget.news.publisherModel!.name!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              horizontalMargin4,
              Text(
                '•',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              horizontalMargin4,
              Text(
                getTimeAgo(widget.news.publishedAt!),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          verticalMargin12,
          Text(
            widget.news.title!,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          if (_isImageLoadFailed) ...[
            verticalMargin8,
            Text(
              widget.news.description!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          verticalMargin4,
          Text(
            timeToRead(widget.news.htmlBody!),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          verticalMargin8,
        ],
      ),
    );
  }
}
