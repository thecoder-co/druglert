// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.body,
    this.statusCode,
  });

  Body? body;
  int? statusCode;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
        statusCode: json["status_code"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "body": body == null ? null : body?.toJson(),
        "status_code": statusCode ?? null,
      };
}

class Body {
  Body({
    this.id,
    this.drugs,
    this.email,
  });

  String? id;
  List<Drug>? drugs;
  String? email;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        id: json["_id"] ?? null,
        drugs: json["drugs"] == null
            ? null
            : List<Drug>.from(json["drugs"].map((x) => Drug.fromJson(x))),
        email: json["email"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id ?? null,
        "email": email ?? null,
      };
}

class Drug {
  Drug({
    this.id,
    this.drugName,
    this.expiryDate,
    this.image,
  });

  String? id;
  String? drugName;
  String? image;
  String? expiryDate;

  factory Drug.fromJson(Map<String, dynamic> json) => Drug(
        id: json["_id"] ?? null,
        drugName: json["drug_name"] ?? null,
        expiryDate: json["expiry_date"] ?? null,
        image: json["image"] ?? null,
      );
}
