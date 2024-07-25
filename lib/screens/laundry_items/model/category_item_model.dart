// To parse this JSON data, do
//
//     final categoryItemModel = categoryItemModelFromJson(jsonString);

import 'dart:convert';

CategoryItemModel categoryItemModelFromJson(String str) =>
    CategoryItemModel.fromJson(json.decode(str));

String categoryItemModelToJson(CategoryItemModel data) =>
    json.encode(data.toJson());

class CategoryItemModel {
  String? message;
  List<Datum>? data;

  CategoryItemModel({
    this.message,
    this.data,
  });

  CategoryItemModel copyWith({
    String? message,
    List<Datum>? data,
  }) =>
      CategoryItemModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) =>
      CategoryItemModel(
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
  String? image;
  int? serviceId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Datum>? items;
  int? categoryId;

  Datum({
    this.id,
    this.name,
    this.arabicName,
    this.image,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
    this.items,
    this.categoryId,
  });

  Datum copyWith({
    int? id,
    String? name,
    String? arabicName,
    String? image,
    int? serviceId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Datum>? items,
    int? categoryId,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        arabicName: arabicName ?? this.arabicName,
        image: image ?? this.image,
        serviceId: serviceId ?? this.serviceId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        items: items ?? this.items,
        categoryId: categoryId ?? this.categoryId,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        image: json["image"],
        serviceId: json["service_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        items: json["items"] == null
            ? []
            : List<Datum>.from(json["items"]!.map((x) => Datum.fromJson(x))),
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "image": image,
        "service_id": serviceId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "category_id": categoryId,
      };
}
