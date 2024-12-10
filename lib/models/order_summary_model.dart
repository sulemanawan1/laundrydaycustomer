// To parse this JSON data, do
//
//     final orderSummaryModel = orderSummaryModelFromJson(jsonString);

import 'dart:convert';

OrderSummaryModel orderSummaryModelFromJson(String str) =>
    OrderSummaryModel.fromJson(json.decode(str));

String orderSummaryModelToJson(OrderSummaryModel data) =>
    json.encode(data.toJson());

class OrderSummaryModel {
  bool? success;
  String? message;
  Data? data;

  OrderSummaryModel({
    this.success,
    this.message,
    this.data,
  });

  OrderSummaryModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      OrderSummaryModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) =>
      OrderSummaryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  double? deliveryFees;
  double? deliveryFeesIncTax;
  double? vat;
  double? discount;
  double? subtotal;
  int? totalItems;
  double? operationFees;

  Data({
    this.deliveryFees,
    this.deliveryFeesIncTax,
    this.vat,
    this.discount,
    this.subtotal,
    this.totalItems,
    this.operationFees,
  });

  Data copyWith({
    double? deliveryFees,
    double? deliveryFeesIncTax,
    double? vat,
    double? discount,
    double? subtotal,
    int? totalItems,
    double? operationFees,
  }) =>
      Data(
        deliveryFees: deliveryFees ?? this.deliveryFees,
        deliveryFeesIncTax: deliveryFeesIncTax ?? this.deliveryFeesIncTax,
        vat: vat ?? this.vat,
        discount: discount ?? this.discount,
        subtotal: subtotal ?? this.subtotal,
        totalItems: totalItems ?? this.totalItems,
        operationFees: operationFees ?? this.operationFees,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deliveryFees: json["delivery_fees"]?.toDouble(),
        deliveryFeesIncTax: json["delivery_fees_inc_tax"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
        discount: json["discount"]?.toDouble(),
        subtotal: json["subtotal"]?.toDouble(),
        totalItems: json["total_items"],
        operationFees: json["operation_fees"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "delivery_fees": deliveryFees,
        "delivery_fees_inc_tax": deliveryFeesIncTax,
        "vat": vat,
        "discount": discount,
        "subtotal": subtotal,
        "total_items": totalItems,
        "operation_fees": operationFees,
      };
}
