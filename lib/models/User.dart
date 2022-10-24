// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.role,
    this.accessToken,
  });

  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  List<String>? role;
  String? accessToken;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        role: List<String>.from(json["role"].map((x) => x)),
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "role": List<dynamic>.from(role!.map((x) => x)),
        "accessToken": accessToken,
      };
}
