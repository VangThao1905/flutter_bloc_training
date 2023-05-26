import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({this.email, required this.id, this.name, this.photo});

  final String? email;
  final String id;
  final String? name;
  final String? photo;

  static const empty = const User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photo];
}
