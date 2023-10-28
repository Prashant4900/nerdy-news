// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobile/gen/env_model.dart';

class AdState {
  AdState(this.initialization);

  Future<InitializationStatus> initialization;

  String get bannerAdsID => EnvModel.bannerAdsId;

  String get bannerAdsImageOnlyId => EnvModel.bannerAdsImageOnlyId;

  String get nativeAdsID => EnvModel.nativeAdsId;

  String get nativeAdsImageOnlyId => EnvModel.nativeAdsImageOnlyId;

  BannerAdListener get bannerAdListener => _bannerAdListener;

  NativeAdListener get nativeAdListener => _nativeAdListener;

  AdRequest get adRequest => const AdRequest();

  final NativeAdListener _nativeAdListener = NativeAdListener(
    onAdLoaded: (ad) => log('Ad loaded: ${ad.adUnitId}.'),
    onAdClosed: (ad) => log('Ad closed: ${ad.adUnitId}.'),
    onAdFailedToLoad: (ad, error) =>
        log('Ad failed to load: $ad.adUnitId}, $error.'),
    onAdOpened: (ad) => log('Ad opened: ${ad.adUnitId}.'),
    onAdClicked: (ad) => log('Ad Click: ${ad.adUnitId}'),
    onAdImpression: (ad) => log('Ad Impression: ${ad.adUnitId}'),
    onPaidEvent: (ad, valueMicros, precision, currencyCode) => log(
      'Ad Paid Event: ${ad.adUnitId} - currencyCode: $currencyCode, valueMicros: $valueMicros, precision: $precision',
    ),
  );

  final BannerAdListener _bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => log('Ad loaded: ${ad.adUnitId}.'),
    onAdClosed: (ad) => log('Ad closed: ${ad.adUnitId}.'),
    onAdFailedToLoad: (ad, error) =>
        log('Ad failed to load: $ad.adUnitId}, $error.'),
    onAdOpened: (ad) => log('Ad opened: ${ad.adUnitId}.'),
    onAdClicked: (ad) => log('Ad Click: ${ad.adUnitId}'),
    onAdImpression: (ad) => log('Ad Impression: ${ad.adUnitId}'),
    onPaidEvent: (ad, valueMicros, precision, currencyCode) => log(
      'Ad Paid Event: ${ad.adUnitId} - currencyCode: $currencyCode, valueMicros: $valueMicros, precision: $precision',
    ),
  );
}
