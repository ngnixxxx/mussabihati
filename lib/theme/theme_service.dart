import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mussabihati/theme/app_theme.dart';
import 'package:mussabihati/theme/backend_theme_types.dart';
import 'package:mussabihati/theme/theme_types.dart';

class ThemeService extends AppTheme {
  Box themeDb;

  Map<String, ThemeType> themeTypeLookup = {
    'light': ThemeType.CAFFEINE,
    'dark': ThemeType.MELATONIN,
  };
  Map<ThemeType, String> themeTypeNameLookup = {
    ThemeType.CAFFEINE: 'light',
    ThemeType.MELATONIN: 'dark',
  };
  @override
  BackendThemeType getRequiredService() {
    return BackendThemeType.HIVE;
  }

  @override
  Future<void> loadSettings() async {
    await Hive.initFlutter();
    themeDb = await Hive.openBox('theme');
    try {
      String themeTypeName = themeDb.get('type');
      themeType = themeTypeLookup[themeTypeName];
      useSystem = themeDb.get('system').toLowerCase() == 'true' ? true : false;
      notifyListeners();
    } catch (e) {
      useSystem = false;
      themeType = ThemeType.CAFFEINE;
      notifyListeners();
    }
  }

  @override
  Future<void> saveSettings() async {
    await Hive.initFlutter();

    themeDb = await Hive.openBox('theme');
    themeDb.put('type', themeTypeNameLookup[themeType]);
    themeDb.put('system', useSystem.toString());
  }
}
