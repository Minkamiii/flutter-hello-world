import 'package:flutter/material.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('locale') ?? LocaleType.en.name;

    _locale = Locale(code);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);

    notifyListeners();
  }
}