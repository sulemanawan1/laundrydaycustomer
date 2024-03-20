import 'dart:convert';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String role;
  final String image;
  final String mobileNumber;
  final String userName;
  final String email;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.image,
    required this.mobileNumber,
    required this.userName,
    required this.email,
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? role,
    String? image,
    String? mobileNumber,
    String? userName,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      image: image ?? this.image,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      userName: userName ?? this.userName,
      email: email ?? this.email,
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
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      role: map['role'] ?? '',
      image: map['image'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, role: $role, image: $image, mobileNumber: $mobileNumber, userName: $userName, email: $email)';
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
      other.email == email;
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
      email.hashCode;
  }
}
