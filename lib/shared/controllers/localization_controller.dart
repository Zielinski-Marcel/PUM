import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController with ChangeNotifier {
  Locale _locale = const Locale('en');

  final List<(String, String)> _languages = [
    ('Polski', 'pl'),
    ('English', 'en'),
  ];

  Locale get locale => _locale;

  List<(String, String)> get languages => List.unmodifiable(_languages);

  String get currentLanguageLabel {
    return _languages.firstWhere((lang) => lang.$2 == _locale.languageCode).$1;
  }

  Future<void> setLocale(String localeCode) async {
    _locale = Locale(localeCode);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', localeCode);
  }

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString('locale') ?? 'en';

    _locale = Locale(localeCode);
    notifyListeners();
  }
}
