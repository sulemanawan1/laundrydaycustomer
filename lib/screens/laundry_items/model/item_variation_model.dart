// To parse this JSON data, do
//
//     final itemVariationModel = itemVariationModelFromJson(jsonString);

import 'dart:convert';

ItemVariationModel itemVariationModelFromJson(String str) =>
    ItemVariationModel.fromJson(json.decode(str));

String itemVariationModelToJson(ItemVariationModel data) =>
    json.encode(data.toJson());

class ItemVariationModel {
  bool? success;
  String? message;
  List<ItemVariation>? itemVariations;

  ItemVariationModel({
    this.success,
    this.message,
    this.itemVariations,
  });

  ItemVariationModel copyWith({
    bool? success,
    String? message,
    List<ItemVariation>? itemVariations,
  }) =>
      ItemVariationModel(
        success: success ?? this.success,
        message: message ?? this.message,
        itemVariations: itemVariations ?? this.itemVariations,
      );

  factory ItemVariationModel.fromJson(Map<String, dynamic> json) =>
      ItemVariationModel(
        success: json["success"],
        message: json["message"],
        itemVariations: json["item_variations"] == null
            ? []
            : List<ItemVariation>.from(
                json["item_variations"]!.map((x) => ItemVariation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "item_variations": itemVariations == null
            ? []
            : List<dynamic>.from(itemVariations!.map((x) => x.toJson())),
      };
}

class ItemVariation {
  int? id;
  String? name;
  String? arabicName;
  double? price;
  int? quantity;
  int? categoryId;
  int? itemId;
  int? serviceTimingId;
  int? hasSize;
  DateTime? createdAt;
  DateTime? updatedAt;

  ItemVariation({
    this.id,
    this.name,
    this.arabicName,
    this.price,
    this.quantity,
    this.categoryId,
    this.itemId,
    this.serviceTimingId,
    this.hasSize,
    this.createdAt,
    this.updatedAt,
  });

  ItemVariation copyWith({
    int? id,
    String? name,
    String? arabicName,
    double? price,
    int? quantity,
    int? categoryId,
    int? itemId,
    int? serviceTimingId,
    int? hasSize,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ItemVariation(
        id: id ?? this.id,
        name: name ?? this.name,
        arabicName: arabicName ?? this.arabicName,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        categoryId: categoryId ?? this.categoryId,
        itemId: itemId ?? this.itemId,
        serviceTimingId: serviceTimingId ?? this.serviceTimingId,
        hasSize: hasSize ?? this.hasSize,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ItemVariation.fromJson(Map<String, dynamic> json) => ItemVariation(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        categoryId: json["category_id"],
        itemId: json["item_id"],
        serviceTimingId: json["service_timing_id"],
        hasSize: json["hasSize"],
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
        "price": price,
        "quantity": quantity,
        "category_id": categoryId,
        "item_id": itemId,
        "service_timing_id": serviceTimingId,
        "hasSize": hasSize,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
