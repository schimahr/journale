import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:journalio/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  late bool _useDarkMode;
  bool get useDarkMode => _useDarkMode;
  late String _preferredLocale;

  Locale get preferredLocale => Locale(_preferredLocale);

  List<String> supportedLocales = ['hr', 'en'];

  int get initialLocaleIndex {
    return supportedLocales.indexOf(_preferredLocale);
  }

  SettingsProvider() {
    _useDarkMode = false;
    _preferredLocale = 'en';
    _loadThemePreference();
    _loadLocalePreference();
  }

  _saveThemePreferences(bool value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(Constants.preferredTheme, value);
    print('prefs saved ' + value.toString());
  }

  _loadThemePreference() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var tempBool = _prefs.getBool(Constants.preferredTheme);
    if (tempBool != null) {
      _useDarkMode = tempBool;
    }
    print('prefs loaded ' + _useDarkMode.toString());
    notifyListeners();
  }

  _loadLocalePreference() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var tempLocale = _prefs.getString(Constants.preferredLocale);
    if (tempLocale != null) {
      _preferredLocale = tempLocale;
    }
    print('prefs loaded ' + _preferredLocale.toString());
    notifyListeners();
  }

  _saveLocalePreferences(String locale) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(Constants.preferredLocale, locale);
    print('prefs saved ' + locale.toString());
  }

  void changeTheme(bool value) {
    _useDarkMode = value;
    _saveThemePreferences(value);
    notifyListeners();
  }

  void changeLocale(int index) {
    String locale = supportedLocales[index];
    _preferredLocale = locale;
    _saveLocalePreferences(locale);
    notifyListeners();
  }
}
