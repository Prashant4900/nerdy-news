import 'package:flutter/foundation.dart';
import 'package:mobile/gen/env_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> init() async {
    await Supabase.initialize(
      url: EnvModel.baseUrl,
      anonKey: EnvModel.anonKey,
      debug: kDebugMode,
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}
