import 'package:flutter/material.dart';
import 'package:flutter_todos/localization/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

const LANGUAGE_CODE = 'language_code';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String languageCode = _pref.getString(LANGUAGE_CODE) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case 'en':
      return const Locale('en', 'EN');
    case 'vi':
      return const Locale('vi', 'VN');
    default:
      return const Locale('en', 'EN');
  }
}

String getTranslated(BuildContext context, String key) {
  String? res = TodoAppLocalizations.of(context)?.translate(key);
  if (res != null) {
    return res;
  }
  return '';
}
