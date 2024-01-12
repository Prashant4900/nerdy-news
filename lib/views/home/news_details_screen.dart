import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart' as parser;
import 'package:mobile/ads/banner_ads_widgets.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/db/share_pref/app_pref.dart';
import 'package:mobile/models/news_model.dart';
import 'package:mobile/utils/date_time.dart';
import 'package:mobile/views/home/bloc/summary/summary_bloc.dart';
import 'package:mobile/widgets/bottom_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({required this.news, super.key});

  final NewsModel news;

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
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
          if (_isReaderMode)
            InkWell(
              onTap: () {
                context
                    .read<SummaryBloc>()
                    .add(GetNewsSummary(news: widget.news));
              },
              child: const Icon(CupertinoIcons.wand_stars),
            )
          else
            emptyWidget,
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
          if (_isReaderMode) _renderReaderView() else _renderWebView(),
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

  Widget _renderWebView() => Expanded(
        child: WebViewWidget(
          controller: controller,
        ),
      );

  Widget _renderReaderView() => Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NewsSummaryWidget(),
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
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
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
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 10,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      formatDate(widget.news.publishedAt!),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 10,
                          ),
                    ),
                  ],
                ),
              ),
              verticalMargin8,
              Padding(
                padding: horizontalPadding12,
                child: Text(
                  widget.news.htmlBody!,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 14,
                      ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      );
}

class NewsSummaryWidget extends StatefulWidget {
  const NewsSummaryWidget({
    super.key,
  });

  @override
  State<NewsSummaryWidget> createState() => _NewsSummaryWidgetState();
}

class _NewsSummaryWidgetState extends State<NewsSummaryWidget> {
  bool _isEnglish = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SummaryBloc, SummaryState>(
      builder: (context, state) {
        if (state.status == SummaryStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == SummaryStatus.success) {
          final news = _isEnglish
              ? state.summaryModel!.english
              : state.summaryModel!.hinglish;
          return Container(
            padding: horizontalPadding16 + verticalPadding12,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isEnglish = !_isEnglish;
                      });
                    },
                    child: Text(_isEnglish ? 'Hindi' : 'English'),
                  ),
                  Text(
                    news!.title!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                  ),
                  verticalMargin4,
                  Text(
                    news.description!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 12,
                        ),
                    textAlign: TextAlign.justify,
                  ),
                  verticalMargin12,
                  Text(
                    news.summarize!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 14,
                        ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          );
        } else {
          return emptyWidget;
        }
      },
    );
  }
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
