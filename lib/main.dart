import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:env_reader/env_reader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mobile/app/app.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/services/supabase_config.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Env.load(
    source: EnvLoader.asset('assets/env/.pro.env'),
    password: 'NerdyNews490',
  );
  await Firebase.initializeApp();
  await AppAnalytics.init();
  await SupabaseConfig.init();
  await setup();
  FlutterNativeSplash.remove();
  runApp(
    const MyApp(),
  );
}
