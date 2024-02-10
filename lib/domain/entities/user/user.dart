import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.image});
  final String id;
  final String firstName;
  final String lastName;
  final String? image;
  final String email;

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        email,
      ];
}
