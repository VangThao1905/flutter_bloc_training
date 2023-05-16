import 'package:authentication_repository/authentication_repository.dart';

abstract class AuthenticationEvent {
  AuthenticationEvent();
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
