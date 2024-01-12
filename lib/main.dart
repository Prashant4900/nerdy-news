import 'dart:async';

import 'package:env_reader/env_reader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobile/ads/ads_state.dart';
import 'package:mobile/analytics/analytics.dart';
import 'package:mobile/app/app.dart';
import 'package:mobile/db/share_pref/app_pref.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/utils/supabase_config.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      // Initialize Splash Screen
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Load Environments Variables
      await Env.load(
        source: EnvLoader.asset('assets/env/.pro.env'),
        // source: EnvLoader.asset('assets/env/.env'),
        password: 'NerdyNews490',
      );

      // Initialize Firebase
      await Firebase.initializeApp();

      // Initialize Analytics in application
      await AppAnalytics.init();

      // Initialize Crashlytics
      await AppCrashlytics.init(enable: !kDebugMode);

      // Initialize Supabase instance
      await SupabaseConfig.init();

      // Initialize AppPref
      await AppPref.init();

      // Set First init date
      await AppPrefCache.setInitialDate();

      // Initialize repositories
      await setup();

      // Initialize Ads
      final initialization = MobileAds.instance.initialize();
      await initialization.then((value) {
        RequestConfiguration(
          tagForChildDirectedTreatment:
              TagForChildDirectedTreatment.unspecified,
          testDeviceIds: ['BEBE06B3C5D72F30071F853BEB6F5512'],
        );
      });
      final adsState = AdState(initialization);

      // Set Status Bar Color
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
      );

      // Remove Splash Screen
      FlutterNativeSplash.remove();

      // Launch application
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
