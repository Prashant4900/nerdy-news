import 'package:flutter/material.dart';
import 'package:mobile/db/share_pref/app_pref.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> changeTheme(ThemeMode themeMode) async {
    await AppPrefCache.setThemeMode(mode: themeMode);
    _themeMode = themeMode;
    notifyListeners();
  }

  Future<void> getTheme() async {
    _themeMode = AppPrefCache.getThemeMode();
    notifyListeners();
  }
}
