import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/extension/string.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/utils/date_time.dart';
import 'package:mobile/utils/time_to_read.dart';
// import 'package:news/model/model.dart';

class PublisherWidget extends StatelessWidget {
  const PublisherWidget({
    required this.news,
    super.key,
  });

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          timeToRead(news.htmlBody!),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Spacer(),
        Assets.svg.icon.svg(
          height: 12,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        horizontalMargin4,
        Text(
          'Nerdy News',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class NewsMetaDataWidget extends StatelessWidget {
  const NewsMetaDataWidget({
    required this.news,
    super.key,
  });

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          news.publisherModel!.name!,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        horizontalMargin4,
        const Text(' • '),
        horizontalMargin4,
        Text(
          getTimeAgo(news.publishedAt!),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    required this.news,
    super.key,
  });

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: news.thumbnail!,
      imageBuilder: (context, imageProvider) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return emptyWidget;
      },
    );
  }
}

class FirstNewsCard extends StatelessWidget {
  const FirstNewsCard({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.95),
          child: ListView(
            padding: horizontalPadding12 + verticalPadding12,
            shrinkWrap: true,
            children: [
              ImageWidget(news: news),
              verticalMargin4,
              Text(
                news.title!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              verticalMargin8,
              NewsMetaDataWidget(news: news),
              verticalMargin12,
              Text(
                news.description!.getFirstFewWords,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              verticalMargin4,
              PublisherWidget(news: news),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondNewsCard extends StatelessWidget {
  const SecondNewsCard({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            padding: horizontalPadding12 + verticalPadding12,
            shrinkWrap: true,
            children: [
              Text(
                news.title!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              verticalMargin4,
              NewsMetaDataWidget(news: news),
              verticalMargin12,
              Text(
                news.description!.getFirstFewWords,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              verticalMargin4,
              PublisherWidget(news: news),
            ],
          ),
        ),
      ),
    );
  }
}

class ThirdNewsCard extends StatelessWidget {
  const ThirdNewsCard({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            padding: horizontalPadding12 + verticalPadding12,
            shrinkWrap: true,
            children: [
              ImageWidget(news: news),
              verticalMargin4,
              Text(
                news.title!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              verticalMargin8,
              NewsMetaDataWidget(news: news),
              verticalMargin4,
              PublisherWidget(news: news),
            ],
          ),
        ),
      ),
    );
  }
}

class FourthNewsCard extends StatelessWidget {
  const FourthNewsCard({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            padding: horizontalPadding12 + verticalPadding12,
            shrinkWrap: true,
            children: [
              Text(
                news.title!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              verticalMargin4,
              NewsMetaDataWidget(news: news),
              verticalMargin4,
              PublisherWidget(news: news),
            ],
          ),
        ),
      ),
    );
  }
}
