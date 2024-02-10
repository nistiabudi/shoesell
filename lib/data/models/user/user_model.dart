import 'dart:convert';

import 'package:eshoes_clean_arch/domain/entities/user/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  const UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
      );
  Map<String, dynamic> toJson() => {
        "_id": id,
        "_firstName": firstName,
        "lastName": lastName,
        "_email": email,
      };
}
