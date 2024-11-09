// To parse this JSON data, do
//
//     final regionModel = regionModelFromJson(jsonString);

import 'dart:convert';

RegionModel regionModelFromJson(String str) =>
    RegionModel.fromJson(json.decode(str));

String regionModelToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
  String? message;
  List<Datum>? data;

  RegionModel({
    this.message,
    this.data,
  });

  RegionModel copyWith({
    String? message,
    List<Datum>? data,
  }) =>
      RegionModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
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
  int? regionId;
  String? nameAr;
  String? nameEn;
  int? capitalCityId;

  Datum({
    this.regionId,
    this.nameAr,
    this.nameEn,
    this.capitalCityId,
  });

  Datum copyWith({
    int? regionId,
    String? nameAr,
    String? nameEn,
    int? capitalCityId,
  }) =>
      Datum(
        regionId: regionId ?? this.regionId,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        capitalCityId: capitalCityId ?? this.capitalCityId,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        regionId: json["region_id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        capitalCityId: json["capital_city_id"],
      );

  Map<String, dynamic> toJson() => {
        "region_id": regionId,
        "name_ar": nameAr,
        "name_en": nameEn,
        "capital_city_id": capitalCityId,
      };
}
