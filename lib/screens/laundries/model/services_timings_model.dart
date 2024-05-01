import 'dart:convert';

class ServicesTimingModel {
  int id;
  String name;
  String description;
  String duration;
  String img;
  ServicesTimingModel({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.img,
  });

  ServicesTimingModel copyWith({
    int? id,
    String? name,
    String? description,
    String? duration,
    String? img,
  }) {
    return ServicesTimingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'img': img,
    };
  }

  factory ServicesTimingModel.fromMap(Map<String, dynamic> map) {
    return ServicesTimingModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      duration: map['duration'] ?? '',
      img: map['img'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServicesTimingModel.fromJson(String source) =>
      ServicesTimingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServiceTypeTime(id: $id, name: $name, description: $description, duration: $duration, img: $img)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServicesTimingModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.duration == duration &&
        other.img == img;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        duration.hashCode ^
        img.hashCode;
  }
}
