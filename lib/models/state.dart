import 'dart:convert';

class Regions {
  bool? success;
  List<Region>? regions;

  Regions({
    this.success,
    this.regions,
  });

  factory Regions.fromJson(String str) => Regions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Regions.fromMap(Map<String, dynamic> json) => Regions(
        success: json["success"],
        regions: json["regions"] == null
            ? []
            : List<Region>.from(json["regions"]!.map((x) => Region.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "regions": regions == null
            ? []
            : List<dynamic>.from(regions!.map((x) => x.toMap())),
      };
}

class Region {
  int? id;
  String? name;
  int? countryId;

  Region({
    this.id,
    this.name,
    this.countryId,
  });

  factory Region.fromJson(String str) => Region.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Region.fromMap(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "country_id": countryId,
      };
}
