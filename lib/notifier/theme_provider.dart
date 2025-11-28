import 'package:flutter/material.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/service/get_it/get_it.dart';
import 'package:hello_world/ui/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  AppThemeType _theme = AppThemeType.light;
  final prefs = getIt<SharedPreferences>();

  ThemeProvider() {
    loadTheme();
  }
  
  AppThemeType get theme => _theme;

  ThemeData get themeData => _theme == AppThemeType.light ? AppTheme.lightTheme : AppTheme.darkTheme;

  ThemeMode get themeMode{
    switch(_theme){
      case AppThemeType.light:
        return ThemeMode.light;
      case AppThemeType.dark:
        return ThemeMode.dark;
    }
  }

  void setTheme(AppThemeType theme) async {
    _theme = theme;
    notifyListeners();

    prefs.setString('theme', theme.name);
  }

  Future<void> loadTheme() async {
    final saved = prefs.getString('theme');

    if (saved != null) {
      _theme = AppThemeType.values.firstWhere(
        (t) => t.name == saved,
        orElse: () => AppThemeType.light,
      );
    }

    notifyListeners();
  }
}