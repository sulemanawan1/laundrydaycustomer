import 'dart:convert';

import 'package:flutter/widgets.dart';

class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? image;
  final String? mobileNumber;
  final String? userName;
  final String? email;
  final String? password;
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.role,
    this.image,
    this.mobileNumber,
    this.userName,
    this.email,
    this.password,
  });



  UserModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? firstName,
    ValueGetter<String?>? lastName,
    ValueGetter<String?>? role,
    ValueGetter<String?>? image,
    ValueGetter<String?>? mobileNumber,
    ValueGetter<String?>? userName,
    ValueGetter<String?>? email,
    ValueGetter<String?>? password,
  }) {
    return UserModel(
      id: id != null ? id() : this.id,
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
      role: role != null ? role() : this.role,
      image: image != null ? image() : this.image,
      mobileNumber: mobileNumber != null ? mobileNumber() : this.mobileNumber,
      userName: userName != null ? userName() : this.userName,
      email: email != null ? email() : this.email,
      password: password != null ? password() : this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'image': image,
      'mobileNumber': mobileNumber,
      'userName': userName,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt(),
      firstName: map['firstName'],
      lastName: map['lastName'],
      role: map['role'],
      image: map['image'],
      mobileNumber: map['mobileNumber'],
      userName: map['userName'],
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, role: $role, image: $image, mobileNumber: $mobileNumber, userName: $userName, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.role == role &&
      other.image == image &&
      other.mobileNumber == mobileNumber &&
      other.userName == userName &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      role.hashCode ^
      image.hashCode ^
      mobileNumber.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      password.hashCode;
  }
}
