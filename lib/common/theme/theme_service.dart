import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends GetxService {
  static const String _prefKey = 'theme_mode'; // 'light' | 'dark' | 'system'

  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  ThemeMode get themeMode => _themeMode.value;
  Rx<ThemeMode> get themeModeRx => _themeMode;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  Future<ThemeService> init() async {
    await _loadThemeFromStorage();
    return this;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
    await _saveThemeToStorage(mode);
  }

  Future<void> toggleDark(bool enableDark) async {
    await setThemeMode(enableDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _loadThemeFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? stored = prefs.getString(_prefKey);
    if (stored == 'dark') {
      _themeMode.value = ThemeMode.dark;
    } else if (stored == 'light') {
      _themeMode.value = ThemeMode.light;
    } else if (stored == 'system') {
      _themeMode.value = ThemeMode.system;
    }
  }

  Future<void> _saveThemeToStorage(ThemeMode mode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = 'light';
    if (mode == ThemeMode.dark) value = 'dark';
    if (mode == ThemeMode.system) value = 'system';
    await prefs.setString(_prefKey, value);
  }
}
