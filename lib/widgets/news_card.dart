import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/utils/date_time.dart';
import 'package:mobile/utils/time_to_read.dart';
import 'package:mobile/views/favorite/bloc/favorite_bloc.dart';
import 'package:mobile/views/home/bloc/summary/summary_bloc.dart';
import 'package:mobile/widgets/bottom_sheet.dart';

void _moveToNewsDetail(BuildContext context, NewsModel news) {
  Navigator.pushNamed(
    context,
    MyRoutes.newsDetailScreen,
    arguments: NewsDetailArguments(newsModel: news),
  ).then((value) {
    context.read<FavoriteBloc>().add(IsFavorite(news: news));
    context.read<SummaryBloc>().add(ResetState());
  });
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
                    Container(
                      width: 14,
                      height: 14,
                      padding: allPadding2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Image.network(news.publisherModel!.icon!),
                    ),
                    horizontalMargin8,
                    Text(
                      news.publisherModel!.name!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 10,
                          ),
                    ),
                  ],
                ),
                verticalMargin8,
                Text(
                  news.title!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalMargin8,
                Row(
                  children: [
                    Text(
                      timeToRead(news.htmlBody!),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 10,
                          ),
                    ),
                    horizontalMargin4,
                    Text(
                      '•',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 10,
                          ),
                    ),
                    horizontalMargin4,
                    Text(
                      getTimeAgo(news.publishedAt!),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 10,
                          ),
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
                width: 90,
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
              Container(
                width: 12,
                height: 12,
                padding: allPadding2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.network(widget.news.publisherModel!.icon!),
              ),
              horizontalMargin8,
              Text(
                widget.news.publisherModel!.name!,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10,
                    ),
              ),
              horizontalMargin4,
              Text(
                '•',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10,
                    ),
              ),
              horizontalMargin4,
              Text(
                getTimeAgo(widget.news.publishedAt!),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10,
                    ),
              ),
            ],
          ),
          verticalMargin8,
          Text(
            widget.news.title!,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (_isImageLoadFailed) ...[
            verticalMargin8,
            Text(
              widget.news.description!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                  ),
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
