import 'dart:convert';

class Cities {
  bool? success;
  List<City>? cities;

  Cities({
    this.success,
    this.cities,
  });

  factory Cities.fromJson(String str) => Cities.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cities.fromMap(Map<String, dynamic> json) => Cities(
        success: json["success"],
        cities: json["cities"] == null
            ? []
            : List<City>.from(json["cities"]!.map((x) => City.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "cities": cities == null
            ? []
            : List<dynamic>.from(cities!.map((x) => x.toMap())),
      };
}

class City {
  int? id;
  String? name;
  int? stateId;
  String? latitude;
  String? longitude;

  City({
    this.id,
    this.name,
    this.stateId,
    this.latitude,
    this.longitude,
  });

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "latitude": latitude,
        "longitude": longitude,
      };
}
