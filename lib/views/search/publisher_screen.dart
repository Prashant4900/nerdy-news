import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/ads/native_ads_widgets.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/models/publisher_model.dart';
import 'package:mobile/views/search/bloc/search_bloc.dart';
import 'package:mobile/widgets/news_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPublisherScreen extends StatefulWidget {
  const MyPublisherScreen({required this.publisher, super.key});

  final PublisherModel publisher;

  @override
  State<MyPublisherScreen> createState() => _MyPublisherScreenState();
}

class _MyPublisherScreenState extends State<MyPublisherScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          context.read<SearchBloc>().add(
                GetNewsByPublisherEvent(
                  publisher: widget.publisher,
                  loadMore: true,
                ),
              );
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.publisher.name!,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await launchUrl(
                Uri.parse(widget.publisher.source!),
                mode: LaunchMode.inAppWebView,
              );
            },
            icon: const Icon(CupertinoIcons.globe),
            tooltip: 'Open in Browser',
          ),
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        bloc: context.read<SearchBloc>()
          ..add(GetNewsByPublisherEvent(publisher: widget.publisher)),
        builder: (context, state) {
          if (state.status == SearchStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == SearchStatus.failure) {
            return Center(
              child: Text(
                state.message!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            );
          } else if (state.status == SearchStatus.success) {
            final newsList = state.newsList;
            if (newsList == null) {
              return const Center(
                child: Text('Oops Nothing here.'),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              itemCount: newsList.length,
              padding: allPadding16,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                if (index % 7 == 0) {
                  return MediumNewsCard(news: newsList[index]);
                }

                if (index % 9 == 0) {
                  return Column(
                    children: [
                      SmallNewsCard(
                        news: newsList[index],
                      ),
                      HomePageNativeAds(
                        key: Key(index.toString()),
                      ),
                    ],
                  );
                }

                return SmallNewsCard(
                  news: newsList[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          } else {
            return const Center(
              child: Text("Opp's Nothing here."),
            );
          }
        },
      ),
    );
  }
}
