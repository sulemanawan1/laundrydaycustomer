import 'dart:convert';

import 'package:flutter/widgets.dart';

class LaundryItemModel {
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
  LaundryItemModel({
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
 

  LaundryItemModel copyWith({
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
    return LaundryItemModel(
      id: id != null ? id() : this.id,
      laundryId: laundryId != null ? laundryId() : this.laundryId,
      name: name != null ? name() : this.name,
      image: image != null ? image() : this.image,
      quantity: quantity != null ? quantity() : this.quantity,
      initialCharges: initialCharges != null ? initialCharges() : this.initialCharges,
      charges: charges != null ? charges() : this.charges,
      category: category != null ? category() : this.category,
      categoryId: categoryId != null ? categoryId() : this.categoryId,
      blanketItemId: blanketItemId != null ? blanketItemId() : this.blanketItemId,
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

  factory LaundryItemModel.fromMap(Map<String, dynamic> map) {
    return LaundryItemModel(
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

  factory LaundryItemModel.fromJson(String source) => LaundryItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LaundryItemModel(id: $id, laundryId: $laundryId, name: $name, image: $image, quantity: $quantity, initialCharges: $initialCharges, charges: $charges, category: $category, categoryId: $categoryId, blanketItemId: $blanketItemId, serviceId: $serviceId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LaundryItemModel &&
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
