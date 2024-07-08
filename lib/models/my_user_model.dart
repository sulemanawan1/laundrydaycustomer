// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? succcess;
  String? message;
  User? user;
  String? token;

  UserModel({
    this.succcess,
    this.message,
    this.user,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        succcess: json["succcess"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "succcess": succcess,
        "message": message,
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? userName;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  Customer? customer;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.userName,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.customer,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        userName: json["user_name"],
        role: json["role"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "user_name": userName,
        "role": role,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "customer": customer?.toJson(),
      };
}

class Customer {
  String? mobileNumber;
  int? userId;

  Customer({
    this.mobileNumber,
    this.userId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        mobileNumber: json["mobile_number"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "mobile_number": mobileNumber,
        "user_id": userId,
      };
}
