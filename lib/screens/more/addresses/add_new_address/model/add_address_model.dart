// To parse this JSON data, do
//
//     final addAddressModel = addAddressModelFromJson(jsonString);

import 'dart:convert';

AddAddressModel addAddressModelFromJson(String str) =>
    AddAddressModel.fromJson(json.decode(str));

String addAddressModelToJson(AddAddressModel data) =>
    json.encode(data.toJson());

class AddAddressModel {
  bool? success;
  String? message;
  Data? data;

  AddAddressModel({
    this.success,
    this.message,
    this.data,
  });

  AddAddressModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      AddAddressModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory AddAddressModel.fromJson(Map<String, dynamic> json) =>
      AddAddressModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? customerId;
  String? googleMapAddress;
  String? addressName;
  double? lat;
  double? lng;
  String? addressDetail;
  String? addressPhoto;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.customerId,
    this.googleMapAddress,
    this.addressName,
    this.lat,
    this.lng,
    this.addressDetail,
    this.addressPhoto,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data copyWith({
    int? customerId,
    String? googleMapAddress,
    String? addressName,
    double? lat,
    double? lng,
    String? addressDetail,
    String? addressPhoto,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      Data(
        customerId: customerId ?? this.customerId,
        googleMapAddress: googleMapAddress ?? this.googleMapAddress,
        addressName: addressName ?? this.addressName,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        addressDetail: addressDetail ?? this.addressDetail,
        addressPhoto: addressPhoto ?? this.addressPhoto,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerId: json["customer_id"],
        googleMapAddress: json["google_map_address"],
        addressName: json["address_name"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        addressDetail: json["address_detail"],
        addressPhoto: json["address_photo"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "google_map_address": googleMapAddress,
        "address_name": addressName,
        "lat": lat,
        "lng": lng,
        "address_detail": addressDetail,
        "address_photo": addressPhoto,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
