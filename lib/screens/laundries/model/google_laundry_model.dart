import 'dart:convert';

class GoogleLaundryModel {
  dynamic name;
  dynamic rating;
  dynamic openingHours;
  dynamic lat;
  dynamic lng;
  dynamic distance;
  dynamic duration;
  dynamic vicinity;

  dynamic originAddresses;
  dynamic destinationAddresses;
  double distanceInKm;
  GoogleLaundryModel({
  
    required this.name,
    required this.rating,
    required this.openingHours,
    required this.lat,
    required this.lng,
    required this.distance,
    required this.duration,
    required this.vicinity,
    required this.originAddresses,
    required this.destinationAddresses,
    required this.distanceInKm,
  });

  GoogleLaundryModel copyWith({
    dynamic name,
    dynamic rating,
    dynamic openingHours,
    dynamic lat,
    dynamic lng,
    dynamic distance,
    dynamic duration,
        dynamic originAddresses,

    dynamic vicinity,
    dynamic destinationAddresses,
    double? distanceInKm,
  }) {
    return GoogleLaundryModel(
      vicinity: vicinity??this.vicinity,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      openingHours: openingHours ?? this.openingHours,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      originAddresses: originAddresses ?? this.originAddresses,
      destinationAddresses: destinationAddresses ?? this.destinationAddresses,
      distanceInKm: distanceInKm ?? this.distanceInKm,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vicinity':vicinity,
      'name': name,
      'rating': rating,
      'openingHours': openingHours,
      'lat': lat,
      'lng': lng,
      'distance': distance,
      'duration': duration,
      'originAddresses': originAddresses,
      'destinationAddresses': destinationAddresses,
      'distanceInKm': distanceInKm,
    };
  }

  factory GoogleLaundryModel.fromMap(Map<String, dynamic> map) {
    return GoogleLaundryModel(
      vicinity: map['vicinity'] ?? null ,
      name: map['name'] ?? null,
      rating: map['rating'] ?? null,
      openingHours: map['openingHours'] ?? null,
      lat: map['lat'] ?? null,
      lng: map['lng'] ?? null,
      distance: map['distance'] ?? null,
      duration: map['duration'] ?? null,
      originAddresses: map['originAddresses'] ?? null,
      destinationAddresses: map['destinationAddresses'] ?? null,
      distanceInKm: map['distanceInKm']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GoogleLaundryModel.fromJson(String source) =>
      GoogleLaundryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DeliveryPickupLaundryModel(name: $name, rating: $rating, openingHours: $openingHours, lat: $lat, lng: $lng, distance: $distance, duration: $duration, duration: $vicinity,originAddresses: $originAddresses, destinationAddresses: $destinationAddresses, distanceInKm: $distanceInKm)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GoogleLaundryModel &&
        other.name == name &&
        other.rating == rating &&
        other.openingHours == openingHours &&
        other.lat == lat &&
        other.lng == lng &&
        other.distance == distance &&
        other.duration == duration &&
        other.vicinity==vicinity&&
        other.originAddresses == originAddresses &&
        other.destinationAddresses == destinationAddresses &&
        other.distanceInKm == distanceInKm;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        rating.hashCode ^
        openingHours.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        distance.hashCode ^
        duration.hashCode ^
        vicinity.hashCode^
        originAddresses.hashCode ^
        destinationAddresses.hashCode ^
        distanceInKm.hashCode;
  }
}
