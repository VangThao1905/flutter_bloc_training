import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todos/localization/app_localizations.dart';
import 'package:flutter_todos/localization/language_constants.dart';
import 'package:flutter_todos/theme/theme.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';

import '../home/view/home_page.dart';
import '../localization/language.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey();

class App extends StatefulWidget {
  final TodosRepository todosRepository;

  const App({Key? key, required this.todosRepository}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    AppState? state = context.findAncestorStateOfType<AppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        print("after change locale:${locale.languageCode}");
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.todosRepository,
      child: AppView(
        locale: _locale,
      ),
    );
  }
}

class AppView extends StatelessWidget {
  Locale? locale;

  AppView({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    if (locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue[800]),
          ),
        ),
      );
    } else {
      print('locale:${locale?.languageCode}');
      return MaterialApp(
        navigatorKey: navigationKey,
        debugShowCheckedModeBanner: false,
        theme: FlutterTodosTheme.light,
        darkTheme: FlutterTodosTheme.dark,
        locale: locale,
        localizationsDelegates: const [
          TodoAppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        // localizationsDelegates: AppLocal,
        supportedLocales: const [Locale('en'), Locale('vi')],
        home: HomePage(),
      );
    }
  }
}
