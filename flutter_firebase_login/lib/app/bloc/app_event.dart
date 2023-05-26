import 'package:authentication_repository/authentication_repository.dart';

class AppEvent {
  AppEvent();
}

class AppLogoutRequested extends AppEvent {
  AppLogoutRequested();
}

class AppUserChanged extends AppEvent {
  AppUserChanged(this.user);

  final User user;
}
