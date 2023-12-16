import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:mobile/ads/banner_ads_widgets.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/db/share_pref/app_pref.dart';
import 'package:mobile/feature/favorite/bloc/favorite_bloc.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/utils/date_time.dart';
import 'package:mobile/views/home/bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({required this.news, super.key});

  final NewsModel news;

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  bool _isSaved = false;
  bool _isReaderMode = false;

  @override
  void initState() {
    super.initState();
    _isReaderMode = AppPrefCache.getReaderMode();
    webViewInit();
  }

  late WebViewController controller;
  double loadingPercentage = 0;

  Future<void> webViewInit() async {
    // Webview Controller
    controller = WebViewController();
    await controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress.toDouble();
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ),
    );
    await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    await controller.loadRequest(
      Uri.parse(widget.news.source!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(widget.news.publisherModel!.icon!),
              backgroundColor: Colors.white,
              minRadius: 10,
              maxRadius: 12,
            ),
            horizontalMargin12,
            Text(
              widget.news.publisherModel!.name!,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              try {
                if (_isSaved) {
                  context.read<FavoriteBloc>().add(
                        DeleteFavoriteEvent(news: widget.news),
                      );
                  setState(() => _isSaved = false);
                } else {
                  context.read<FavoriteBloc>().add(
                        AddTOFavoriteEvent(news: widget.news),
                      );
                  setState(() => _isSaved = true);
                }
              } catch (e) {
                log(e.toString());
              }
            },
            child: _isSaved
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.bookmark_border),
          ),
          IconButton(
            onPressed: () {
              newsButtonSheet(context, widget.news);
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          if (loadingPercentage < 90)
            LinearProgressIndicator(
              value: loadingPercentage / 100,
              color: Theme.of(context).colorScheme.onBackground,
              backgroundColor: Theme.of(context).colorScheme.background,
            )
          else
            const SizedBox.shrink(),
          Expanded(
            child: _isReaderMode ? _renderReaderView() : _renderWebView(),
          ),
          BannerAdWidget(key: Key(widget.key.toString())),
        ],
      ),
      floatingActionButton: Padding(
        padding: bottomPadding48,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.background,
          onPressed: () => setState(() => _isReaderMode = !_isReaderMode),
          child: _isReaderMode
              ? Icon(
                  CupertinoIcons.book_fill,
                  color: Theme.of(context).colorScheme.onBackground,
                )
              : Icon(
                  CupertinoIcons.book,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
        ),
      ),
    );
  }

  Widget _renderWebView() => WebViewWidget(
        controller: controller,
      );

  Widget _renderReaderView() => GestureDetector(
        child: SingleChildScrollView(
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
              ),
              verticalMargin8,
              Padding(
                padding: horizontalPadding12,
                child: Text(
                  widget.news.title!,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              verticalMargin12,
              Padding(
                padding: horizontalPadding12,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.news.publisherModel!.icon!),
                      radius: 8,
                    ),
                    horizontalMargin12,
                    Text(
                      widget.news.publisherModel!.name!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    Text(
                      formatDate(widget.news.publishedAt!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              verticalMargin8,
              Padding(
                padding: horizontalPadding12,
                child: Text(
                  widget.news.htmlBody!,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      );
}

String cleanHTML(String htmlBody) {
  final document = parser.parse(htmlBody);

  final pictureTags = document.querySelectorAll('picture');

  for (final pictureTag in pictureTags) {
    for (final child in pictureTag.children) {
      pictureTag.parent!.insertBefore(child, pictureTag);
    }
    pictureTag.remove();
  }

  final modifiedHtmlString = document.outerHtml.replaceAll('\n\n', '\n');
  return modifiedHtmlString;
}
