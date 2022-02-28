// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:task_app/src/models/user_hive.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    this.token,
    this.user,
    required this.msg,
  });

  bool ok;
  String? token;
  User? user;
  String msg;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        token: json["token"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "token": token,
        "user": user?.toJson(),
        "msg": msg,
      };
}
