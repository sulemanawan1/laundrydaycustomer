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

  UserModel copyWith({
    bool? succcess,
    String? message,
    User? user,
    String? token,
  }) =>
      UserModel(
        succcess: succcess ?? this.succcess,
        message: message ?? this.message,
        user: user ?? this.user,
        token: token ?? this.token,
      );

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
  String? mobileNumber;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? status;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.userName,
    this.mobileNumber,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? image,
    String? userName,
    String? mobileNumber,
    String? email,
    String? gender,
    String? dateOfBirth,
    String? status,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        image: image ?? this.image,
        userName: userName ?? this.userName,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        status: status ?? this.status,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        userName: json["user_name"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        status: json["status"],
        role: json["role"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "user_name": userName,
        "mobile_number": mobileNumber,
        "email": email,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "status": status,
        "role": role,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
