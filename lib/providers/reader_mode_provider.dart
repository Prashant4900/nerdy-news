import 'package:flutter/material.dart';
import 'package:mobile/db/share_pref/app_pref.dart';

class ReaderModeProvider extends ChangeNotifier {
  bool _status = false;

  bool get status => _status;

  Future<void> changeMode({required bool enable}) async {
    final flag = await AppPrefCache.setReaderMode(enable: enable);
    _status = flag;
    notifyListeners();
  }

  Future<void> getReaderMode() async {
    _status = AppPrefCache.getReaderMode();
    notifyListeners();
  }
}
