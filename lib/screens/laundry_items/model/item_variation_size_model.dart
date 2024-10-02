// To parse this JSON data, do
//
//     final itemVariationSizeModel = itemVariationSizeModelFromJson(jsonString);

import 'dart:convert';

ItemVariationSizeModel itemVariationSizeModelFromJson(String str) =>
    ItemVariationSizeModel.fromJson(json.decode(str));

String itemVariationSizeModelToJson(ItemVariationSizeModel data) =>
    json.encode(data.toJson());

class ItemVariationSizeModel {
  bool? success;
  String? message;
  ItemVariationSize? itemVariationSize;

  ItemVariationSizeModel({
    this.success,
    this.message,
    this.itemVariationSize,
  });

  ItemVariationSizeModel copyWith({
    bool? success,
    String? message,
    ItemVariationSize? itemVariationSize,
  }) =>
      ItemVariationSizeModel(
        success: success ?? this.success,
        message: message ?? this.message,
        itemVariationSize: itemVariationSize ?? this.itemVariationSize,
      );

  factory ItemVariationSizeModel.fromJson(Map<String, dynamic> json) =>
      ItemVariationSizeModel(
        success: json["success"],
        message: json["message"],
        itemVariationSize: json["item_variation_size"] == null
            ? null
            : ItemVariationSize.fromJson(json["item_variation_size"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "item_variation_size": itemVariationSize?.toJson(),
      };
}

class ItemVariationSize {
  int? id;
  int? itemVariationId;
  int? prefixLength;
  int? prefixWidth;
  int? postfixLength;
  int? postfixWidth;
  DateTime? createdAt;
  DateTime? updatedAt;

  ItemVariationSize({
    this.id,
    this.itemVariationId,
    this.prefixLength,
    this.prefixWidth,
    this.postfixLength,
    this.postfixWidth,
    this.createdAt,
    this.updatedAt,
  });

  ItemVariationSize copyWith({
    int? id,
    int? itemVariationId,
    int? prefixLength,
    int? prefixWidth,
    int? postfixLength,
    int? postfixWidth,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ItemVariationSize(
        id: id ?? this.id,
        itemVariationId: itemVariationId ?? this.itemVariationId,
        prefixLength: prefixLength ?? this.prefixLength,
        prefixWidth: prefixWidth ?? this.prefixWidth,
        postfixLength: postfixLength ?? this.postfixLength,
        postfixWidth: postfixWidth ?? this.postfixWidth,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ItemVariationSize.fromJson(Map<String, dynamic> json) =>
      ItemVariationSize(
        id: json["id"],
        itemVariationId: json["item_variation_id"],
        prefixLength: json["prefix_length"],
        prefixWidth: json["prefix_width"],
        postfixLength: json["postfix_length"],
        postfixWidth: json["postfix_width"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_variation_id": itemVariationId,
        "prefix_length": prefixLength,
        "prefix_width": prefixWidth,
        "postfix_length": postfixLength,
        "postfix_width": postfixWidth,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
