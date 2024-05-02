import 'dart:convert';

import 'package:flutter/widgets.dart';

class OrderStatusModel {
  int id;
  String description;
  int orderId;
  int status;
  bool isActive;
  DateTime? createdAt;
  OrderStatusModel({
    required this.id,
    required this.description,
    required this.orderId,
    required this.status,
    required this.isActive,
    required this.createdAt,
  });

  OrderStatusModel copyWith({
    int? id,
    String? description,
    int? orderId,
    int? status,
    bool? isActive,
    ValueGetter<DateTime?>? createdAt,
  }) {
    return OrderStatusModel(
      id: id ?? this.id,
      description: description ?? this.description,
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'orderId': orderId,
      'status': status,
      'isActive': isActive,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      id: map['id']?.toInt() ?? 0,
      description: map['description'] ?? '',
      orderId: map['orderId']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      isActive: map['isActive'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusModel.fromJson(String source) =>
      OrderStatusModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderStatusModel(id: $id, description: $description, orderId: $orderId, status: $status, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderStatusModel &&
        other.id == id &&
        other.description == description &&
        other.orderId == orderId &&
        other.status == status &&
        other.isActive == isActive &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        orderId.hashCode ^
        status.hashCode ^
        isActive.hashCode ^
        createdAt.hashCode;
  }
}
