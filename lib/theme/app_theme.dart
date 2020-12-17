import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mussabihati/theme/backend_theme_types.dart';
import 'package:mussabihati/theme/theme_types.dart';

import 'melatonin_theme.dart';
import 'caffeine_theme.dart';

abstract class AppTheme extends ChangeNotifier {
  ThemeType themeType;
  bool useSystem;
  Box themeDb;

  AppTheme({
    this.themeType = ThemeType.CAFFEINE,
    this.useSystem = true,
  }) : super() {
    loadSettings();
    saveSettings();
  }

  Future<void> initialize() async {
    themeDb = await Hive.openBox('theme');
    await loadSettings();
    notifyListeners();
  }

  void setThemeType(ThemeType type) {
    useSystem = false;
    themeType = type;
    saveSettings();
    notifyListeners();
  }

  void setUseSystem(bool val) {
    useSystem = val;
    saveSettings();
    notifyListeners();
  }

  ThemeData getCustomTheme() {
    switch (themeType) {
      case ThemeType.CAFFEINE:
        return lightTheme;
      case ThemeType.MELATONIN:
        return darkTheme;
      default:
        return lightTheme;
    }
  }

  ThemeData getLightTheme() {
    if (useSystem) {
      return lightTheme;
    } else {
      return getCustomTheme();
    }
  }

  ThemeData getDarkTheme() {
    if (useSystem) {
      return darkTheme;
    } else {
      return getCustomTheme();
    }
  }

  BackendThemeType getRequiredService();
  Future<void> loadSettings();
  Future<void> saveSettings();
}
