// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  bool success;
  Data data;

  Country({
    required this.success,
    required this.data,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String name;
  String alpha2;
  String alpha3;
  String numCode;
  String stdCode;
  String capital;
  String currency;
  String currencyName;
  String currencySymbol;
  String tld;
  String native;
  String region;
  String subregion;
  String timezones;
  String translations;
  String latitude;
  String longitude;
  String emoji;
  String emojiU;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int flag;
  String wikiDataId;

  Data({
    required this.id,
    required this.name,
    required this.alpha2,
    required this.alpha3,
    required this.numCode,
    required this.stdCode,
    required this.capital,
    required this.currency,
    required this.currencyName,
    required this.currencySymbol,
    required this.tld,
    required this.native,
    required this.region,
    required this.subregion,
    required this.timezones,
    required this.translations,
    required this.latitude,
    required this.longitude,
    required this.emoji,
    required this.emojiU,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.flag,
    required this.wikiDataId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        alpha2: json["alpha2"],
        alpha3: json["alpha3"],
        numCode: json["num_code"],
        stdCode: json["std_code"],
        capital: json["capital"],
        currency: json["currency"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
        tld: json["tld"],
        native: json["native"],
        region: json["region"],
        subregion: json["subregion"],
        timezones: json["timezones"],
        translations: json["translations"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        emoji: json["emoji"],
        emojiU: json["emojiU"],
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
        "alpha2": alpha2,
        "alpha3": alpha3,
        "num_code": numCode,
        "std_code": stdCode,
        "capital": capital,
        "currency": currency,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
        "tld": tld,
        "native": native,
        "region": region,
        "subregion": subregion,
        "timezones": timezones,
        "translations": translations,
        "latitude": latitude,
        "longitude": longitude,
        "emoji": emoji,
        "emojiU": emojiU,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "flag": flag,
        "wikiDataId": wikiDataId,
      };
}
