// Env Reader Auto-Generated Model File
// Created at 2024-01-02 23:22:33.486081
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀
import 'package:env_reader/env_reader.dart';

/// Auto-generated environment model class.
///
/// This class represents environment variables parsed from the .env file.
/// Each static variable corresponds to an environment variable,
/// with default values provided for safety
/// `false` for [bool], `0` for [int], `0.0` for [double] and `VARIABLE_NAME` for [String].
class EnvModel {
  /// Value of `SUPABASE_PASSWORD` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('SUPABASE_PASSWORD') ?? 'SUPABASE_PASSWORD';
  /// ```
  static String supabasePassword = Env.read<String>('SUPABASE_PASSWORD') ?? 'SUPABASE_PASSWORD';

  /// Value of `BASE_URL` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('BASE_URL') ?? 'BASE_URL';
  /// ```
  static String baseUrl = Env.read<String>('BASE_URL') ?? 'BASE_URL';

  /// Value of `ANON_KEY` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('ANON_KEY') ?? 'ANON_KEY';
  /// ```
  static String anonKey = Env.read<String>('ANON_KEY') ?? 'ANON_KEY';

  /// Value of `BANNER_ADS_ID` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('BANNER_ADS_ID') ?? 'BANNER_ADS_ID';
  /// ```
  static String bannerAdsId = Env.read<String>('BANNER_ADS_ID') ?? 'BANNER_ADS_ID';

  /// Value of `NATIVE_ADS_ID` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('NATIVE_ADS_ID') ?? 'NATIVE_ADS_ID';
  /// ```
  static String nativeAdsId = Env.read<String>('NATIVE_ADS_ID') ?? 'NATIVE_ADS_ID';

}
