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
  List<Item>? data;

  CategoryItemModel({
    this.message,
    this.data,
  });

  CategoryItemModel copyWith({
    String? message,
    List<Item>? data,
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
            : List<Item>.from(json["data"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Item {
  int? id;
  int? count;
  double? total_price;
  String? name;
  String? arabicName;
  String? image;
  int? serviceId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Item>? items;
  int? categoryId;

  Item({
    this.count,
    this.total_price,
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

  Item copyWith({
    int? count,
    double? total_price,
    int? id,
    String? name,
    String? arabicName,
    String? image,
    int? serviceId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Item>? items,
    int? categoryId,
  }) =>
      Item(
        count: count ?? this.count,
        total_price: total_price ?? this.total_price,
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        total_price: json['total_price'],
        count: json['count'],
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
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "total_price": total_price,
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
