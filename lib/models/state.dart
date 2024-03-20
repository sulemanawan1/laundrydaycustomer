// To parse this JSON data, do
//
//     final state = stateFromJson(jsonString);

import 'dart:convert';

StateModel stateFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  bool success;
  List<Datum> data;

  StateModel({
    required this.success,
    required this.data,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String name;
  int countryId;
  CountryCode countryCode;
  String fipsCode;
  String iso2;
  dynamic type;
  String latitude;
  String longitude;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int flag;
  String wikiDataId;

  Datum({
    required this.id,
    required this.name,
    required this.countryId,
    required this.countryCode,
    required this.fipsCode,
    required this.iso2,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.flag,
    required this.wikiDataId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        countryCode: countryCodeValues.map[json["country_code"]]!,
        fipsCode: json["fips_code"],
        iso2: json["iso2"],
        type: json["type"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        flag: json["flag"],
        wikiDataId: json["wikiDataId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "country_code": countryCodeValues.reverse[countryCode],
        "fips_code": fipsCode,
        "iso2": iso2,
        "type": type,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "flag": flag,
        "wikiDataId": wikiDataId,
      };
}

enum CountryCode { sa }

final countryCodeValues = EnumValues({"SA": CountryCode.sa});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
