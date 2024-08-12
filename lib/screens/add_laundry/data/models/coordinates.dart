import 'dart:convert';

import 'package:flutter/widgets.dart';

class Coordinates {
  double? lat;
  double? lng;
  Coordinates({
    this.lat,
    this.lng,
  });
 

  Coordinates copyWith({
    ValueGetter<double?>? lat,
    ValueGetter<double?>? lng,
  }) {
    return Coordinates(
      lat: lat != null ? lat() : this.lat,
      lng: lng != null ? lng() : this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Coordinates.fromJson(String source) => Coordinates.fromMap(json.decode(source));

  @override
  String toString() => 'Coordinates(lat: $lat, lng: $lng)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Coordinates &&
      other.lat == lat &&
      other.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
