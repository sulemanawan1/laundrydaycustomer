// To parse this JSON data, do
//
//     final subscriptionDistrictModel = subscriptionDistrictModelFromJson(jsonString);

import 'dart:convert';

SubscriptionDistrictModel subscriptionDistrictModelFromJson(String str) =>
    SubscriptionDistrictModel.fromJson(json.decode(str));

String subscriptionDistrictModelToJson(SubscriptionDistrictModel data) =>
    json.encode(data.toJson());

class SubscriptionDistrictModel {
  String? message;
  Data? data;

  SubscriptionDistrictModel({
    this.message,
    this.data,
  });

  SubscriptionDistrictModel copyWith({
    String? message,
    Data? data,
  }) =>
      SubscriptionDistrictModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SubscriptionDistrictModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionDistrictModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? districtId;
  String? nameAr;
  String? nameEn;
  int? cityId;
  int? regionId;
  String? boundaries;

  Data({
    this.districtId,
    this.nameAr,
    this.nameEn,
    this.cityId,
    this.regionId,
    this.boundaries,
  });

  Data copyWith({
    int? districtId,
    String? nameAr,
    String? nameEn,
    int? cityId,
    int? regionId,
    String? boundaries,
  }) =>
      Data(
        districtId: districtId ?? this.districtId,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        cityId: cityId ?? this.cityId,
        regionId: regionId ?? this.regionId,
        boundaries: boundaries ?? this.boundaries,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        districtId: json["district_id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        cityId: json["city_id"],
        regionId: json["region_id"],
        boundaries: json["boundaries"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "name_ar": nameAr,
        "name_en": nameEn,
        "city_id": cityId,
        "region_id": regionId,
        "boundaries": boundaries,
      };
}
