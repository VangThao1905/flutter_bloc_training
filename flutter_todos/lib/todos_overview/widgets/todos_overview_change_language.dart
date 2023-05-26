import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:flutter_todos/todos_overview/bloc/todos_overview_event.dart';

import '../../localization/language.dart';
import '../../localization/language_constants.dart';

@visibleForTesting
enum LanguageOption { english, vietnamese }

class TodosOverviewChangeLanguageButton extends StatelessWidget {
  const TodosOverviewChangeLanguageButton({super.key});

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    App.setLocale(navigationKey.currentContext!, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        tooltip: 'Options',
        onSelected: (options) {
          switch (options) {
            case LanguageOption.english:
              // context
              //     .read<TodosOverviewBloc>()
              //     .add(const TodosOverviewToggleAllRequested());
              _changeLanguage(Language(1, '🇺🇸', 'English', 'en'));
              break;
            case LanguageOption.vietnamese:
              // context
              //     .read<TodosOverviewBloc>()
              //     .add(const TodosOverviewClearCompletedRequested());
              _changeLanguage(Language(2, '🇻🇳', 'Vietnamese', 'vi'));
              break;
          }
        },
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
                value: LanguageOption.english, child: Text('🇺🇸 English')),
            const PopupMenuItem(
                value: LanguageOption.vietnamese,
                child: Text('🇻🇳 Vietnamese')),
          ];
        },
        icon: const Icon(Icons.language));
  }
}
