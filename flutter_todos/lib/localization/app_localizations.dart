import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TodoAppLocalizations {
  late Locale locale;

  TodoAppLocalizations({required this.locale});

  static TodoAppLocalizations? of(BuildContext context) {
    return Localizations.of<TodoAppLocalizations>(
        context, TodoAppLocalizations);
  }

  late Map<String, String> _localizedValues;

  Future<void> load() async {
    String jsonStringValues =
        await rootBundle.loadString('language/app_${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedValues[key];
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<TodoAppLocalizations> delegate =
      _TodoAppLocalizationsDelegate();
}

class _TodoAppLocalizationsDelegate
    extends LocalizationsDelegate<TodoAppLocalizations> {
  const _TodoAppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<TodoAppLocalizations> load(Locale locale) async {
    TodoAppLocalizations localization = TodoAppLocalizations(locale: locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<TodoAppLocalizations> old) => false;
}
