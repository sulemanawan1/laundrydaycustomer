import 'dart:convert';

class Ratings {
  int id;
  double rating;
  String prefixName;
  String name;
  String image;
  Ratings({
    required this.id,
    required this.rating,
    required this.prefixName,
    required this.name,
    required this.image,
  });

  Ratings copyWith({
    int? id,
    double? rating,
    String? prefixName,
    String? name,
    String? image,
  }) {
    return Ratings(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      prefixName: prefixName ?? this.prefixName,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rating': rating,
      'prefixName': prefixName,
      'name': name,
      'image': image,
    };
  }

  factory Ratings.fromMap(Map<String, dynamic> map) {
    return Ratings(
      id: map['id']?.toInt() ?? 0,
      rating: map['rating']?.toDouble() ?? 0.0,
      prefixName: map['prefixName'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Ratings.fromJson(String source) =>
      Ratings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, rating: $rating, prefixName: $prefixName, name: $name, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ratings &&
        other.id == id &&
        other.rating == rating &&
        other.prefixName == prefixName &&
        other.name == name &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rating.hashCode ^
        prefixName.hashCode ^
        name.hashCode ^
        image.hashCode;
  }
}
