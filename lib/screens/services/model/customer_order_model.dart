// To parse this JSON data, do
//
//     final customerOrderModel = customerOrderModelFromJson(jsonString);

import 'dart:convert';

CustomerOrderModel customerOrderModelFromJson(String str) =>
    CustomerOrderModel.fromJson(json.decode(str));

String customerOrderModelToJson(CustomerOrderModel data) =>
    json.encode(data.toJson());

class CustomerOrderModel {
  bool? success;
  String? message;
  List<Order>? order;

  CustomerOrderModel({
    this.success,
    this.message,
    this.order,
  });

  CustomerOrderModel copyWith({
    bool? success,
    String? message,
    List<Order>? order,
  }) =>
      CustomerOrderModel(
        success: success ?? this.success,
        message: message ?? this.message,
        order: order ?? this.order,
      );

  factory CustomerOrderModel.fromJson(Map<String, dynamic> json) =>
      CustomerOrderModel(
        success: json["success"],
        message: json["message"],
        order: json["order"] == null
            ? []
            : List<Order>.from(json["order"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "order": order == null
            ? []
            : List<dynamic>.from(order!.map((x) => x.toJson())),
      };
}

class Order {
  int? id;
  String? status;
  String? branchName;
  String? type;
  DateTime? countDownStart;
  DateTime? countDownEnd;
  List<OrderStatus>? orderStatuses;

  Order({
    this.id,
    this.status,
    this.branchName,
    this.type,
    this.countDownStart,
    this.countDownEnd,
    this.orderStatuses,
  });

  Order copyWith({
    int? id,
    String? status,
    String? branchName,
    String? type,
    DateTime? countDownStart,
    DateTime? countDownEnd,
    List<OrderStatus>? orderStatuses,
  }) =>
      Order(
        id: id ?? this.id,
        status: status ?? this.status,
        branchName: branchName ?? this.branchName,
        type: type ?? this.type,
        countDownStart: countDownStart ?? this.countDownStart,
        countDownEnd: countDownEnd ?? this.countDownEnd,
        orderStatuses: orderStatuses ?? this.orderStatuses,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        status: json["status"],
        branchName: json["branch_name"],
        type: json["type"],
        countDownStart: json["count_down_start"] == null
            ? null
            : DateTime.parse(json["count_down_start"]),
        countDownEnd: json["count_down_end"] == null
            ? null
            : DateTime.parse(json["count_down_end"]),
        orderStatuses: json["order_statuses"] == null
            ? []
            : List<OrderStatus>.from(
                json["order_statuses"]!.map((x) => OrderStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "branch_name": branchName,
        "type": type,
        "count_down_start": countDownStart?.toIso8601String(),
        "count_down_end": countDownEnd?.toIso8601String(),
        "order_statuses": orderStatuses == null
            ? []
            : List<dynamic>.from(orderStatuses!.map((x) => x.toJson())),
      };
}

class OrderStatus {
  int? id;
  int? orderId;
  String? status;
  String? type;
  DateTime? statusTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderStatus({
    this.id,
    this.orderId,
    this.status,
    this.type,
    this.statusTime,
    this.createdAt,
    this.updatedAt,
  });

  OrderStatus copyWith({
    int? id,
    int? orderId,
    String? status,
    String? type,
    DateTime? statusTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      OrderStatus(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        status: status ?? this.status,
        type: type ?? this.type,
        statusTime: statusTime ?? this.statusTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        id: json["id"],
        orderId: json["order_id"],
        status: json["status"],
        type: json["type"],
        statusTime: json["status_time"] == null
            ? null
            : DateTime.parse(json["status_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "status": status,
        "type": type,
        "status_time": statusTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
