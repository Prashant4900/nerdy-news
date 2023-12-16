part of 'app_pref.dart';

enum AppPrefKey {
  // Keys for the app preferences
  initialDate('initial_date'),
  readerMode('reader_mode'),
  themeMode('theme_mode'),
  userID('user_id'),
  skipAuthPage('skip_auth_page');

  // property to get the key as string
  const AppPrefKey(this.key);
  final String key;
}
