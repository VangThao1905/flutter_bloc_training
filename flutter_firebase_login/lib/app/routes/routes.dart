import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_login/app/bloc/app_state.dart';
import 'package:flutter_firebase_login/login/view/login_page.dart';

import '../../home/view/home_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
    AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
