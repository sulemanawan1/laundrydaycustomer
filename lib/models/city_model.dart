// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  String? message;
  List<Datum>? data;

  CityModel({
    this.message,
    this.data,
  });

  CityModel copyWith({
    String? message,
    List<Datum>? data,
  }) =>
      CityModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
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
  int? cityId;
  int? regionId;
  String? nameAr;
  String? nameEn;

  Datum({
    this.cityId,
    this.regionId,
    this.nameAr,
    this.nameEn,
  });

  Datum copyWith({
    int? cityId,
    int? regionId,
    String? nameAr,
    String? nameEn,
  }) =>
      Datum(
        cityId: cityId ?? this.cityId,
        regionId: regionId ?? this.regionId,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        cityId: json["city_id"],
        regionId: json["region_id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "region_id": regionId,
        "name_ar": nameAr,
        "name_en": nameEn,
      };
}
