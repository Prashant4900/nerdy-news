import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:env_reader/env_reader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobile/ads/ads_state.dart';
import 'package:mobile/app/app.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/services/supabase_config.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      if (kDebugMode) {
        await Env.load(
          source: EnvLoader.asset('assets/env/.env'),
          password: 'NerdyNews490',
        );
      } else {
        await Env.load(
          source: EnvLoader.asset('assets/env/.pro.env'),
          password: 'NerdyNews490',
        );
      }

      await Firebase.initializeApp();

      await AppAnalytics.init();
      await AppCrashlytics.init(enable: !kDebugMode);
      await SupabaseConfig.init();
      await setup();
      final initialization = MobileAds.instance.initialize();
      await initialization.then((value) {
        RequestConfiguration(
          tagForChildDirectedTreatment:
              TagForChildDirectedTreatment.unspecified,
          testDeviceIds: ['BEBE06B3C5D72F30071F853BEB6F5512'],
        );
      });
      final adsState = AdState(initialization);
      FlutterNativeSplash.remove();
      runApp(
        Provider.value(
          value: adsState,
          builder: (context, child) => const MyApp(),
        ),
      );
    },
    AppCrashlytics.recodeError,
  );
}
