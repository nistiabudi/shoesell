import 'dart:convert';

import 'package:eshoes_clean_arch/data/models/user/user_model.dart';

AuthenticationResponseModel authenticationResponseModelFromJson(String str) =>
    AuthenticationResponseModel.fromJson(json.decode(str));

String authenticationResponseModelToJson(AuthenticationResponseModel data) =>
    json.encode(data.toJson());

class AuthenticationResponseModel {
  AuthenticationResponseModel({required this.token, required this.user});
  final String token;
  final UserModel user;

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponseModel(
        token: json["token"],
        user: json["user"],
      );
  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}
