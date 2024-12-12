// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  bool? success;
  String? message;
  List<Coupon>? coupon;

  CouponModel({
    this.success,
    this.message,
    this.coupon,
  });

  CouponModel copyWith({
    bool? success,
    String? message,
    List<Coupon>? coupon,
  }) =>
      CouponModel(
        success: success ?? this.success,
        message: message ?? this.message,
        coupon: coupon ?? this.coupon,
      );

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        success: json["success"],
        message: json["message"],
        coupon: json["coupon"] == null
            ? []
            : List<Coupon>.from(json["coupon"]!.map((x) => Coupon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "coupon": coupon == null
            ? []
            : List<dynamic>.from(coupon!.map((x) => x.toJson())),
      };
}

class Coupon {
  int? id;
  String? code;
  String? name;
  String? description;
  double? discount;
  String? type;
  double? minimumOrderAmount;
  int? maxUses;
  int? maxUsesPerUser;
  DateTime? startDate;
  DateTime? expiryDate;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Coupon({
    this.id,
    this.code,
    this.name,
    this.description,
    this.discount,
    this.type,
    this.minimumOrderAmount,
    this.maxUses,
    this.maxUsesPerUser,
    this.startDate,
    this.expiryDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Coupon copyWith({
    int? id,
    String? code,
    String? name,
    String? description,
    double? discount,
    String? type,
    double? minimumOrderAmount,
    int? maxUses,
    int? maxUsesPerUser,
    DateTime? startDate,
    DateTime? expiryDate,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Coupon(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        description: description ?? this.description,
        discount: discount ?? this.discount,
        type: type ?? this.type,
        minimumOrderAmount: minimumOrderAmount ?? this.minimumOrderAmount,
        maxUses: maxUses ?? this.maxUses,
        maxUsesPerUser: maxUsesPerUser ?? this.maxUsesPerUser,
        startDate: startDate ?? this.startDate,
        expiryDate: expiryDate ?? this.expiryDate,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        description: json["description"],
        discount: json["discount"]?.toDouble(),
        type: json["type"],
        minimumOrderAmount: json["minimum_order_amount"]?.toDouble(),
        maxUses: json["max_uses"],
        maxUsesPerUser: json["max_uses_per_user"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        expiryDate: json["expiry_date"] == null
            ? null
            : DateTime.parse(json["expiry_date"]),
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "description": description,
        "discount": discount,
        "type": type,
        "minimum_order_amount": minimumOrderAmount,
        "max_uses": maxUses,
        "max_uses_per_user": maxUsesPerUser,
        "start_date": startDate?.toIso8601String(),
        "expiry_date": expiryDate?.toIso8601String(),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
