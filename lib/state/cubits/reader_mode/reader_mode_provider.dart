import 'package:flutter/material.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/utils/app_pref.dart';

class ReaderModeProvider extends ChangeNotifier {
  Future<bool> get readerMode async => CacheHelper.getReaderMode();

  Future<void> setReaderMode({required bool readerMode}) async {
    await CacheHelper.saveReaderMode(
      key: PreferenceKey.readerMode,
      readerMode: readerMode,
    );
    notifyListeners();
  }
}
