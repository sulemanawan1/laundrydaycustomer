// To parse this JSON data, do
//
//     final myAddressModel = myAddressModelFromJson(jsonString);

import 'dart:convert';

MyAddressModel myAddressModelFromJson(String str) =>
    MyAddressModel.fromJson(json.decode(str));

String myAddressModelToJson(MyAddressModel data) => json.encode(data.toJson());

class MyAddressModel {
  bool? success;
  String? message;
  List<Address>? addresses;

  MyAddressModel({
    this.success,
    this.message,
    this.addresses,
  });

  MyAddressModel copyWith({
    bool? success,
    String? message,
    List<Address>? addresses,
  }) =>
      MyAddressModel(
        success: success ?? this.success,
        message: message ?? this.message,
        addresses: addresses ?? this.addresses,
      );

  factory MyAddressModel.fromJson(Map<String, dynamic> json) => MyAddressModel(
        success: json["success"],
        message: json["message"],
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
      };
}

class Address {
  int? id;
  int? userId;
  String? googleMapAddress;
  String? addressDetail;
  double? lat;
  double? lng;
  String? country;
  String? city;
  String? district;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.userId,
    this.googleMapAddress,
    this.addressDetail,
    this.lat,
    this.lng,
    this.country,
    this.city,
    this.district,
    this.createdAt,
    this.updatedAt,
  });

  Address copyWith({
    int? id,
    int? userId,
    String? googleMapAddress,
    String? addressDetail,
    double? lat,
    double? lng,
    String? country,
    String? city,
    String? district,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Address(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        googleMapAddress: googleMapAddress ?? this.googleMapAddress,
        addressDetail: addressDetail ?? this.addressDetail,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        country: country ?? this.country,
        city: city ?? this.city,
        district: district ?? this.district,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        googleMapAddress: json["google_map_address"],
        addressDetail: json["address_detail"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        country: json["country"],
        city: json["city"],
        district: json["district"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "google_map_address": googleMapAddress,
        "address_detail": addressDetail,
        "lat": lat,
        "lng": lng,
        "country": country,
        "city": city,
        "district": district,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
