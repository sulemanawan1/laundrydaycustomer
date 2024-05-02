import 'dart:convert';

class ServicesTimingModel {
  int id;
  String name;
  String description;
  int duration;
  String type;
  String img;
  ServicesTimingModel({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.type,
    required this.img,
  });

  ServicesTimingModel copyWith({
    int? id,
    String? name,
    String? description,
    int? duration,
    String? type,
    String? img,
  }) {
    return ServicesTimingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'type': type,
      'img': img,
    };
  }

  factory ServicesTimingModel.fromMap(Map<String, dynamic> map) {
    return ServicesTimingModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      duration: map['duration']?.toInt() ?? 0,
      type: map['type'] ?? '',
      img: map['img'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServicesTimingModel.fromJson(String source) =>
      ServicesTimingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServicesTimingModel(id: $id, name: $name, description: $description, duration: $duration, type: $type, img: $img)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServicesTimingModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.duration == duration &&
        other.type == type &&
        other.img == img;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        duration.hashCode ^
        type.hashCode ^
        img.hashCode;
  }
}
