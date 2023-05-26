import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  AppState._({required this.status, this.user = User.empty});

  final AppStatus status;
  final User user;

  AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
