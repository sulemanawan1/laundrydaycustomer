// To parse this JSON data, do
//
//     final serviceTimingModel = serviceTimingModelFromJson(jsonString);

import 'dart:convert';

ServiceTimingModel serviceTimingModelFromJson(String str) =>
    ServiceTimingModel.fromJson(json.decode(str));

String serviceTimingModelToJson(ServiceTimingModel data) =>
    json.encode(data.toJson());

class ServiceTimingModel {
  String? message;
  List<Datum>? data;

  ServiceTimingModel({
    this.message,
    this.data,
  });

  ServiceTimingModel copyWith({
    String? message,
    List<Datum>? data,
  }) =>
      ServiceTimingModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ServiceTimingModel.fromJson(Map<String, dynamic> json) =>
      ServiceTimingModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? name;
  String? arabicName;
  String? description;
  String? arabicDescription;
  int? duration;
  String? type;
  String? arabicType;
  String? image;
  int? serviceId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.arabicName,
    this.description,
    this.arabicDescription,
    this.duration,
    this.type,
    this.arabicType,
    this.image,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
  });

  Datum copyWith({
    int? id,
    String? name,
    String? arabicName,
    String? description,
    String? arabicDescription,
    int? duration,
    String? type,
    String? arabicType,
    String? image,
    int? serviceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        arabicName: arabicName ?? this.arabicName,
        description: description ?? this.description,
        arabicDescription: arabicDescription ?? this.arabicDescription,
        duration: duration ?? this.duration,
        type: type ?? this.type,
        arabicType: arabicType ?? this.arabicType,
        image: image ?? this.image,
        serviceId: serviceId ?? this.serviceId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        description: json["description"],
        arabicDescription: json["arabic_description"],
        duration: json["duration"],
        type: json["type"],
        arabicType: json["arabic_type"],
        image: json["image"],
        serviceId: json["service_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "description": description,
        "arabic_description": arabicDescription,
        "duration": duration,
        "type": type,
        "arabic_type": arabicType,
        "image": image,
        "service_id": serviceId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
