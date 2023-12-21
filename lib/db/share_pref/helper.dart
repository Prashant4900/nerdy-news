part of 'app_pref.dart';

class AppPrefCache {
  // Set user initial date
  static Future<bool> setInitialDate() async {
    final cacheDate = getInitialDate();

    if (cacheDate != '') {
      log('User Date Already Saved');
      return false;
    }

    log('User Date Saved');
    final flag = await AppPref.save(
      AppPrefKey.initialDate,
      DateTime.now().toString(),
    );

    return flag;
  }

  static String getInitialDate() {
    final cache = AppPref.get(AppPrefKey.initialDate, '') as String;
    final date = DateTime.tryParse(cache);

    if (date == null) {
      return '';
    }

    final formattedDate = DateFormat('MMMM y').format(date);

    return formattedDate;
  }

  static Future<bool> setAuthSkip({bool skip = false}) async {
    return AppPref.save(AppPrefKey.skipAuthPage, skip);
  }

  static bool getAuthSkip() {
    final flag = AppPref.get(AppPrefKey.skipAuthPage, false) as bool;

    return flag;
  }

  static Future<bool> setUserID(String uid) async {
    final isSaved = await AppPref.save(AppPrefKey.userID, uid);
    log('Set User ID isSaved: $isSaved, UID: $uid');
    return isSaved;
  }

  static String getUserID() {
    final uid = AppPref.get(AppPrefKey.userID, '') as String;
    log('Get User ID: $uid');
    return uid;
  }

  static Future<bool> clearUserID() async {
    final isClear = await AppPref.remove(AppPrefKey.userID);
    log('User ID Successfully clear: $isClear');
    return isClear;
  }

  static Future<bool> setReaderMode({required bool enable}) async {
    await AppPref.save(AppPrefKey.readerMode, enable);
    log('Set Reader Mode isSaved: $enable');
    return enable;
  }

  static bool getReaderMode() {
    final flag = AppPref.get(AppPrefKey.readerMode, false) as bool;
    log('Get Reader Mode: $flag');
    return flag;
  }

  static Future<ThemeMode> setThemeMode({required ThemeMode mode}) async {
    var modeValue = 0;
    if (mode == ThemeMode.system) {
      modeValue = 0;
    }

    if (mode == ThemeMode.light) {
      modeValue = 1;
    }

    if (mode == ThemeMode.dark) {
      modeValue = -1;
    }

    final flag = await AppPref.save(AppPrefKey.themeMode, modeValue);
    log('Set Theme Mode isSaved: $mode $modeValue $flag');
    return mode;
  }

  static ThemeMode getThemeMode() {
    final mode = AppPref.get(AppPrefKey.themeMode, 0) as int;
    log('Theme State: $mode');

    switch (mode) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case -1:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
