import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/gen/colors.gen.dart';
import 'package:mobile/gen/env_model.dart';

class HomePageNativeAds extends StatefulWidget {
  const HomePageNativeAds({required super.key});

  @override
  State<HomePageNativeAds> createState() => _HomePageNativeAdsState();
}

class _HomePageNativeAdsState extends State<HomePageNativeAds> {
  NativeAd? nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAds(context);
  }

  void _loadAds(BuildContext context) {
    setState(() {
      _nativeAdIsLoaded = false;
    });
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    nativeAd = NativeAd(
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: isDarkTheme ? MyColors.backgroundDark : null,
        primaryTextStyle: NativeTemplateTextStyle(
          style: NativeTemplateFontStyle.bold,
          size: 14,
          textColor: isDarkTheme ? MyColors.textDark : null,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          style: NativeTemplateFontStyle.bold,
          size: 22,
          textColor: isDarkTheme ? MyColors.textDark : null,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: isDarkTheme ? MyColors.textDark : null,
        ),
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: isDarkTheme ? MyColors.textDark : null,
        ),
      ),
      // adUnitId: 'ca-app-pub-8291423818234072/7306179377',
      adUnitId: EnvModel.nativeAdsId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          log('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          log('$NativeAd failedToLoad: $error');
          setState(() {
            _nativeAdIsLoaded = false;
          });
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (nativeAd != null && _nativeAdIsLoaded)
        ? Padding(
            padding: topPadding4,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width - 16,
                minHeight: 250,
                maxHeight: 350,
              ),
              child: Center(child: AdWidget(ad: nativeAd!)),
            ),
          )
        : emptyWidget;
  }
}
