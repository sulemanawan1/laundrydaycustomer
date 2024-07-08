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
  int? customerId;
  String? googleMapAddress;
  String? addressName;
  String? addressDetail;
  String? addressPhoto;
  double? lat;
  double? lng;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.customerId,
    this.googleMapAddress,
    this.addressName,
    this.addressDetail,
    this.addressPhoto,
    this.lat,
    this.lng,
    this.createdAt,
    this.updatedAt,
  });

  Address copyWith({
    int? id,
    int? customerId,
    String? googleMapAddress,
    String? addressName,
    String? addressDetail,
    String? addressPhoto,
    double? lat,
    double? lng,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Address(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        googleMapAddress: googleMapAddress ?? this.googleMapAddress,
        addressName: addressName ?? this.addressName,
        addressDetail: addressDetail ?? this.addressDetail,
        addressPhoto: addressPhoto ?? this.addressPhoto,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        customerId: json["customer_id"],
        googleMapAddress: json["google_map_address"],
        addressName: json["address_name"],
        addressDetail: json["address_detail"],
        addressPhoto: json["address_photo"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "google_map_address": googleMapAddress,
        "address_name": addressName,
        "address_detail": addressDetail,
        "address_photo": addressPhoto,
        "lat": lat,
        "lng": lng,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
