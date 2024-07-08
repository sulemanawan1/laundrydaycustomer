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
  int? id;
  int? customerId;
  String? googleMapAddress;
  String? addressName;
  String? addressDetail;
  String? addressPhoto;
  double? lat;
  int? lng;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
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

  Data copyWith({
    int? id,
    int? customerId,
    String? googleMapAddress,
    String? addressName,
    String? addressDetail,
    String? addressPhoto,
    double? lat,
    int? lng,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        customerId: json["customer_id"],
        googleMapAddress: json["google_map_address"],
        addressName: json["address_name"],
        addressDetail: json["address_detail"],
        addressPhoto: json["address_photo"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"],
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
