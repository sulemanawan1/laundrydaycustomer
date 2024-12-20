// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) =>
    DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  String? message;
  List<Datum>? data;

  DistrictModel({
    this.message,
    this.data,
  });

  DistrictModel copyWith({
    String? message,
    List<Datum>? data,
  }) =>
      DistrictModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? districtId;
  String? nameAr;
  String? nameEn;
  int? cityId;
  int? regionId;
  String? boundaries;

  Datum({
    this.districtId,
    this.nameAr,
    this.nameEn,
    this.cityId,
    this.regionId,
    this.boundaries,
  });

  Datum copyWith({
    int? districtId,
    String? nameAr,
    String? nameEn,
    int? cityId,
    int? regionId,
    String? boundaries,
  }) =>
      Datum(
        districtId: districtId ?? this.districtId,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        cityId: cityId ?? this.cityId,
        regionId: regionId ?? this.regionId,
        boundaries: boundaries ?? this.boundaries,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
