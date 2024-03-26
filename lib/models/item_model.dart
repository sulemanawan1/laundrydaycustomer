import 'dart:convert';

import 'package:flutter/widgets.dart';

class ItemModel {
  int? id;
  int? laundryId;
  String? name;
  String? image;
  int? quantity;
  double? initialCharges;
  double? charges;
  String? category;
  int? categoryId;
  int? blanketItemId;
  final int? serviceId;
  ItemModel({
    this.id,
    this.laundryId,
    this.name,
    this.image,
    this.quantity,
    this.initialCharges,
    this.charges,
    this.category,
    this.categoryId,
    this.blanketItemId,
    this.serviceId,
  });

  ItemModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<int?>? laundryId,
    ValueGetter<String?>? name,
    ValueGetter<String?>? image,
    ValueGetter<int?>? quantity,
    ValueGetter<double?>? initialCharges,
    ValueGetter<double?>? charges,
    ValueGetter<String?>? category,
    ValueGetter<int?>? categoryId,
    ValueGetter<int?>? blanketItemId,
    ValueGetter<int?>? serviceId,
  }) {
    return ItemModel(
      id: id != null ? id() : this.id,
      laundryId: laundryId != null ? laundryId() : this.laundryId,
      name: name != null ? name() : this.name,
      image: image != null ? image() : this.image,
      quantity: quantity != null ? quantity() : this.quantity,
      initialCharges:
          initialCharges != null ? initialCharges() : this.initialCharges,
      charges: charges != null ? charges() : this.charges,
      category: category != null ? category() : this.category,
      categoryId: categoryId != null ? categoryId() : this.categoryId,
      blanketItemId:
          blanketItemId != null ? blanketItemId() : this.blanketItemId,
      serviceId: serviceId != null ? serviceId() : this.serviceId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'laundryId': laundryId,
      'name': name,
      'image': image,
      'quantity': quantity,
      'initialCharges': initialCharges,
      'charges': charges,
      'category': category,
      'categoryId': categoryId,
      'blanketItemId': blanketItemId,
      'serviceId': serviceId,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id']?.toInt(),
      laundryId: map['laundryId']?.toInt(),
      name: map['name'],
      image: map['image'],
      quantity: map['quantity']?.toInt(),
      initialCharges: map['initialCharges']?.toDouble(),
      charges: map['charges']?.toDouble(),
      category: map['category'],
      categoryId: map['categoryId']?.toInt(),
      blanketItemId: map['blanketItemId']?.toInt(),
      serviceId: map['serviceId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(id: $id, laundryId: $laundryId, name: $name, image: $image, quantity: $quantity, initialCharges: $initialCharges, charges: $charges, category: $category, categoryId: $categoryId, blanketItemId: $blanketItemId, serviceId: $serviceId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.id == id &&
        other.laundryId == laundryId &&
        other.name == name &&
        other.image == image &&
        other.quantity == quantity &&
        other.initialCharges == initialCharges &&
        other.charges == charges &&
        other.category == category &&
        other.categoryId == categoryId &&
        other.blanketItemId == blanketItemId &&
        other.serviceId == serviceId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        laundryId.hashCode ^
        name.hashCode ^
        image.hashCode ^
        quantity.hashCode ^
        initialCharges.hashCode ^
        charges.hashCode ^
        category.hashCode ^
        categoryId.hashCode ^
        blanketItemId.hashCode ^
        serviceId.hashCode;
  }
}

class Carpets extends ItemModel {
  double? length;
  double? width;
  int? prefixLength;
  int? postfixLength;
  int? prefixWidth;
  int? postfixWidth;
  double? size;

  Carpets({
    int? id,
    int? laundryId,
    String? name,
    String? image,
    int? quantity,
    double? initialCharges,
    double? charges,
    String? category,
    int? categoryId,
    int? blanketItemId,
    final int? serviceId,
    this.length,
    this.width,
    this.prefixLength,
    this.postfixLength,
    this.prefixWidth,
    this.postfixWidth,
    this.size,
  }) : super(
            id: id,
            name: name,
            laundryId: laundryId,
            quantity: quantity,
            image: image,
            charges: charges,
            initialCharges: initialCharges,
            categoryId: categoryId,
            blanketItemId: blanketItemId,
            serviceId: serviceId);

 

  

  Map<String, dynamic> toMap() {
    return {
      'length': length,
      'width': width,
      'prefixLength': prefixLength,
      'postfixLength': postfixLength,
      'prefixWidth': prefixWidth,
      'postfixWidth': postfixWidth,
      'size': size,
    };
  }

  factory Carpets.fromMap(Map<String, dynamic> map) {
    return Carpets(
      length: map['length']?.toDouble(),
      width: map['width']?.toDouble(),
      prefixLength: map['prefixLength']?.toInt(),
      postfixLength: map['postfixLength']?.toInt(),
      prefixWidth: map['prefixWidth']?.toInt(),
      postfixWidth: map['postfixWidth']?.toInt(),
      size: map['size']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Carpets.fromJson(String source) => Carpets.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Carpets(length: $length, width: $width, prefixLength: $prefixLength, postfixLength: $postfixLength, prefixWidth: $prefixWidth, postfixWidth: $postfixWidth, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Carpets &&
      other.length == length &&
      other.width == width &&
      other.prefixLength == prefixLength &&
      other.postfixLength == postfixLength &&
      other.prefixWidth == prefixWidth &&
      other.postfixWidth == postfixWidth &&
      other.size == size;
  }

  @override
  int get hashCode {
    return length.hashCode ^
      width.hashCode ^
      prefixLength.hashCode ^
      postfixLength.hashCode ^
      prefixWidth.hashCode ^
      postfixWidth.hashCode ^
      size.hashCode;
  }
}
