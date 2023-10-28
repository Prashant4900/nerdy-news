import 'dart:developer';

import 'package:analytics/analytics.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:html/parser.dart' as parser;
import 'package:mobile/ads/ads_state.dart';
import 'package:mobile/ads/banner_ads_widgets.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/state/blocs/favorite/favorite_bloc.dart';
import 'package:mobile/state/cubits/reader_mode/reader_mode_provider.dart';
import 'package:mobile/state/providers/favorite_state/favorite_state_provider.dart';
import 'package:mobile/utils/date_time.dart';
import 'package:mobile/views/home/bottom_sheet.dart';
import 'package:news/news.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
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
  BannerAd? bannerAd;
  bool buttonShow = true;

  @override
  void initState() {
    super.initState();
    webViewInit();
    _setReaderMode();
    _isArticleSaved();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: adState.bannerAdsImageOnlyId,
          listener: adState.bannerAdListener,
          request: const AdRequest(),
        )..load();
      });
    });
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

  // void scrollToTop() {
  //   controller.runJavaScript("window.scrollTo({top: 0, behavior: 'smooth'});");
  //   // floatingButtonVisibility();
  // }

  void floatingButtonVisibility(double scrollDelta) {
    if (scrollDelta < 0) {
      // Scrolling down
      if (buttonShow) {
        setState(() {
          buttonShow = false;
        });
      }
    } else {
      // Scrolling up
      if (!buttonShow) {
        setState(() {
          buttonShow = true;
        });
      }
    }
  }

  Future<void> _setReaderMode() async {
    final provider = Provider.of<ReaderModeProvider>(context, listen: false);
    _isReaderMode = await provider.readerMode;
  }

  Future<void> _isArticleSaved() async {
    final provider = Provider.of<FavoriteStateProvider>(context, listen: false);
    await provider.isBookmarked(widget.news);
    _isSaved = await provider.isFavorite;
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
        leading: emptyWidget,
        actions: [
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
      bottomNavigationBar: Visibility(
        visible: buttonShow,
        child: BottomAppBar(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              IconButton(
                onPressed: () => setState(() => _isReaderMode = !_isReaderMode),
                icon: _isReaderMode
                    ? const Icon(CupertinoIcons.book_fill)
                    : const Icon(CupertinoIcons.book),
              ),
              IconButton(
                onPressed: () {
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
                icon: _isSaved
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_border),
              ),
              IconButton(
                onPressed: () => Share.share(
                  'Hey Checkout this News ${widget.news.source}',
                  subject: widget.news.title,
                ).whenComplete(
                  () async => appAnalytics.log(
                    LogEvent.share,
                    newsID: widget.news.id,
                    newsTitle: widget.news.title,
                  ),
                ),
                icon: const Icon(Icons.share),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderWebView() => WebViewWidget(
        controller: controller,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
            Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer()
                ..onUpdate = (details) {
                  floatingButtonVisibility(details.primaryDelta!);
                },
            ),
          ),
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
                child: Html(
                  data: cleanHTML(widget.news.htmlBody!),
                  shrinkWrap: true,
                  doNotRenderTheseTags: const {
                    'figcaption',
                    'blockquote',
                    'figure',
                  },
                  onAnchorTap: (url, attributes, element) => _launchUrl(url!),
                  style: {
                    'a': Style(
                      textDecoration: TextDecoration.none,
                    ),
                    '*': Style(
                      padding: HtmlPaddings.symmetric(vertical: 4),
                      margin: Margins.zero,
                    ),
                    'img': Style(
                      width: Width(
                        MediaQuery.of(context).size.width / 1.08,
                      ),
                    ),
                    'p': Style.fromTextStyle(
                      Theme.of(context).textTheme.bodyMedium!,
                    ).copyWith(
                      textAlign: TextAlign.justify,
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      );
}

Future<void> _launchUrl(String url) async {
  final url0 = Uri.parse(url);

  if (!await launchUrl(url0)) {
    throw Exception('Could not launch $url0');
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

  final modifiedHtmlString = document.outerHtml;
  return modifiedHtmlString;
}
