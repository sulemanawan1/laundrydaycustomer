import 'dart:convert';

class DeliveryPickupLaundryModel {
  dynamic name;
  dynamic rating;
  dynamic openingHours;
  dynamic lat;
  dynamic lng;
  dynamic distance;
  dynamic duration;
  dynamic originAddresses;
  dynamic destinationAddresses;
  double distanceInKm;
  DeliveryPickupLaundryModel({
    required this.name,
    required this.rating,
    required this.openingHours,
    required this.lat,
    required this.lng,
    required this.distance,
    required this.duration,
    required this.originAddresses,
    required this.destinationAddresses,
    required this.distanceInKm,
  });

  DeliveryPickupLaundryModel copyWith({
    dynamic name,
    dynamic rating,
    dynamic openingHours,
    dynamic lat,
    dynamic lng,
    dynamic distance,
    dynamic duration,
    dynamic originAddresses,
    dynamic destinationAddresses,
    double? distanceInKm,
  }) {
    return DeliveryPickupLaundryModel(
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

  factory DeliveryPickupLaundryModel.fromMap(Map<String, dynamic> map) {
    return DeliveryPickupLaundryModel(
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

  factory DeliveryPickupLaundryModel.fromJson(String source) =>
      DeliveryPickupLaundryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DeliveryPickupLaundryModel(name: $name, rating: $rating, openingHours: $openingHours, lat: $lat, lng: $lng, distance: $distance, duration: $duration, originAddresses: $originAddresses, destinationAddresses: $destinationAddresses, distanceInKm: $distanceInKm)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeliveryPickupLaundryModel &&
        other.name == name &&
        other.rating == rating &&
        other.openingHours == openingHours &&
        other.lat == lat &&
        other.lng == lng &&
        other.distance == distance &&
        other.duration == duration &&
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
        originAddresses.hashCode ^
        destinationAddresses.hashCode ^
        distanceInKm.hashCode;
  }
}
