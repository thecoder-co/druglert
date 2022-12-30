// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.accessToken,
    this.message,
    this.statusCode,
  });

  String? accessToken;
  String? message;
  int? statusCode;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json["access_token"] ?? null,
        message: json["message"] ?? null,
        statusCode: json["status_code"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken ?? null,
        "message": message ?? null,
        "status_code": statusCode ?? null,
      };
}
