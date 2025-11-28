import 'package:flutter/material.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/service/get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  final prefs = getIt<SharedPreferences>();

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final code = prefs.getString('locale') ?? LocaleType.en.name;

    _locale = Locale(code);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await prefs.setString('locale', locale.languageCode);

    notifyListeners();
  }
}