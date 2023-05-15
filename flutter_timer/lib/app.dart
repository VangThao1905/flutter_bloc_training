import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer/timer/view/timer_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer app',
      theme: ThemeData(
          primaryColor: const Color.fromARGB(109, 234, 255, 1),
          colorScheme: const ColorScheme.light(
              secondary: Color.fromARGB(72, 74, 126, 1)
          )
      ),
      home: const TimerPage(),
    );
  }
}