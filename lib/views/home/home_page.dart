import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobile/ads/ads_state.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/state/blocs/news/news_bloc.dart';
import 'package:mobile/views/error/error_screen.dart';
import 'package:mobile/widgets/news_card.dart';
import 'package:mobile/widgets/shimmer.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NewsBloc, NewsState>(
          bloc: context.read<NewsBloc>()..add(const NewsLoadEvent()),
          builder: (context, state) {
            if (state is NewsInitialState || state is NewsLoadingState) {
              return Column(
                children: [
                  AppBar(
                    title: Text(
                      'Nerdy News',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const NewsListShimmerWidget(),
                ],
              );
            } else if (state is NewsErrorState) {
              return MyErrorScreen(
                onTap: () {
                  context.read<NewsBloc>().add(const NewsLoadEvent());
                },
              );
            } else if (state is NewsLoadedState) {
              final newsList = state.newsList;

              return NestedScrollView(
                floatHeaderSlivers: true,
                controller: context.read<NewsBloc>().newsScrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      floating: true,
                      title: Text(
                        'Nerdy News',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ];
                },
                body: RefreshIndicator(
                  onRefresh: () async {
                    context.read<NewsBloc>().add(const NewsLoadEvent());
                  },
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final news = newsList[index];

                      if (index % 5 == 0) {
                        return Padding(
                          padding: horizontalPadding16 + verticalPadding4,
                          child: MediumNewsCard(news: news),
                        );
                      } else if (index % 13 == 0) {
                        return Column(
                          children: [
                            Padding(
                              padding: horizontalPadding16 + verticalPadding4,
                              child: SmallNewsCard(news: news),
                            ),
                            LoadNativeAds(key: Key(index.toString())),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: horizontalPadding16 + verticalPadding4,
                          child: SmallNewsCard(news: news),
                        );
                      }
                    },
                    separatorBuilder: (context, index) => const Divider(
                      endIndent: 16,
                      indent: 16,
                    ),
                    itemCount: newsList.length,
                  ),
                ),
              );
            } else {
              return Center(child: Text('We working on this $state'));
            }
          },
        ),
      ),
    );
  }
}

class LoadNativeAds extends StatefulWidget {
  const LoadNativeAds({super.key});

  @override
  State<LoadNativeAds> createState() => _LoadNativeAdsState();
}

class _LoadNativeAdsState extends State<LoadNativeAds> {
  // NativeAd? nativeAd;
  BannerAd? bannerAd;

  // bool flag = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        // nativeAd = NativeAd(
        //   factoryId: widget.key.toString(),
        //   adUnitId: adState.nativeAdsID,
        //   // listener: adState.nativeAdListener,
        //   listener: NativeAdListener(
        //     onAdLoaded: (ad) {
        //       setState(() {
        //         flag = true;
        //       });
        //     },
        //   ),
        //   request: adState.adRequest,
        // )..load();
        bannerAd = BannerAd(
          size: AdSize.mediumRectangle,
          adUnitId: adState.bannerAdsID,
          listener: adState.bannerAdListener,
          request: const AdRequest(),
        )..load();
      });
    });
  }

  @override
  void dispose() {
    // if (nativeAd != null) {
    //   nativeAd!.dispose();
    // }
    if (bannerAd != null) {
      bannerAd!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bannerAd != null
        ? SizedBox(
            height: 50,
            child: AdWidget(ad: bannerAd!),
          )
        : emptyWidget;
    // return flag
    //     ? ConstrainedBox(
    //         constraints: const BoxConstraints(
    //           minHeight: 100,
    //           minWidth: 100,
    //         ),
    //         child: AdWidget(ad: nativeAd!),
    //       )
    //     : Container(
    //         height: 60,
    //         color: Colors.pink,
    //       );
  }
}
