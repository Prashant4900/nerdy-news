import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/utils/app_pref.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial(ThemeMode.system));

  Future<void> changeTheme(ThemeMode themeMode) async {
    await CacheHelper.saveTheme(PreferenceKey.themeMode, themeMode);
    emit(ThemeChanged(themeMode));
  }

  Future<void> getTheme() async {
    final themeMode = await CacheHelper.getCurrentTheme();
    emit(ThemeChanged(themeMode));
  }
}
