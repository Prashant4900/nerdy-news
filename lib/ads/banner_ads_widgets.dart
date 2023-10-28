import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobile/ads/ads_state.dart';
import 'package:mobile/constants/commons.dart';
import 'package:provider/provider.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({required super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: adState.bannerAdsID,
          listener: adState.bannerAdListener,
          request: const AdRequest(),
        )..load();
      });
    });
  }

  @override
  void dispose() {
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
  }
}

class DisplayBannerAdWidget extends StatefulWidget {
  const DisplayBannerAdWidget({required super.key});

  @override
  State<DisplayBannerAdWidget> createState() => _DisplayBannerAdWidgetState();
}

class _DisplayBannerAdWidgetState extends State<DisplayBannerAdWidget> {
  BannerAd? bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
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
    if (bannerAd != null) {
      bannerAd!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bannerAd != null
        ? ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 250,
              minHeight: 50,
            ),
            child: AdWidget(ad: bannerAd!),
          )
        : emptyWidget;
  }
}
