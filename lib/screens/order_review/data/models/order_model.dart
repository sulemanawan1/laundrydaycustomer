// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  bool? success;
  String? message;
  Order? order;

  OrderModel({
    this.success,
    this.message,
    this.order,
  });

  OrderModel copyWith({
    bool? success,
    String? message,
    Order? order,
  }) =>
      OrderModel(
        success: success ?? this.success,
        message: message ?? this.message,
        order: order ?? this.order,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        success: json["success"],
        message: json["message"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "order": order?.toJson(),
      };
}

class Order {
  int? id;
  int? customerId;
  int? serviceId;
  int? categoryId;
  int? serviceTimingId;
  int? branchId;
  String? country;
  String? city;
  String? area;
  String? shopAddress;
  String? customerAddress;
  String? isRated;
  String? branchName;
  String? category;
  String? type;
  String? paymentStatus;
  String? paymentMethod;
  double? itemTotalPrice;
  int? totalItems;
  double? totalPrice;
  double? deliveryFee;
  double? vat;
  double? operationFee;
  String? note;
  String? recording;
  String? status;
  String? invoice;
  String? pickupInvoice;
  DateTime? countDownStart;
  DateTime? countDownEnd;
  String? customerAvailability;
  String? code;
  double? branchLat;
  double? branchLng;
  double? customerLat;
  double? customerLng;
  DateTime? createdAt;
  DateTime? updatedAt;
  Service? service;
  Customer? customer;
  List<OrderStatus>? orderStatuses;
  OrderDeliveries? orderDeliveries;

  Order({
    this.id,
    this.customerId,
    this.serviceId,
    this.categoryId,
    this.serviceTimingId,
    this.branchId,
    this.country,
    this.city,
    this.area,
    this.shopAddress,
    this.customerAddress,
    this.isRated,
    this.branchName,
    this.category,
    this.type,
    this.paymentStatus,
    this.paymentMethod,
    this.itemTotalPrice,
    this.totalItems,
    this.totalPrice,
    this.deliveryFee,
    this.vat,
    this.operationFee,
    this.note,
    this.recording,
    this.status,
    this.invoice,
    this.pickupInvoice,
    this.countDownStart,
    this.countDownEnd,
    this.customerAvailability,
    this.code,
    this.branchLat,
    this.branchLng,
    this.customerLat,
    this.customerLng,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.customer,
    this.orderStatuses,
    this.orderDeliveries,
  });

  Order copyWith({
    int? id,
    int? customerId,
    int? serviceId,
    int? categoryId,
    int? serviceTimingId,
    int? branchId,
    String? country,
    String? city,
    String? area,
    String? shopAddress,
    String? customerAddress,
    String? isRated,
    String? branchName,
    String? category,
    String? type,
    String? paymentStatus,
    String? paymentMethod,
    double? itemTotalPrice,
    int? totalItems,
    double? totalPrice,
    double? deliveryFee,
    double? vat,
    double? operationFee,
    String? note,
    String? recording,
    String? status,
    String? invoice,
    String? pickupInvoice,
    DateTime? countDownStart,
    DateTime? countDownEnd,
    String? customerAvailability,
    String? code,
    double? branchLat,
    double? branchLng,
    double? customerLat,
    double? customerLng,
    DateTime? createdAt,
    DateTime? updatedAt,
    Service? service,
    Customer? customer,
    List<OrderStatus>? orderStatuses,
    OrderDeliveries? orderDeliveries,
  }) =>
      Order(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        serviceId: serviceId ?? this.serviceId,
        categoryId: categoryId ?? this.categoryId,
        serviceTimingId: serviceTimingId ?? this.serviceTimingId,
        branchId: branchId ?? this.branchId,
        country: country ?? this.country,
        city: city ?? this.city,
        area: area ?? this.area,
        shopAddress: shopAddress ?? this.shopAddress,
        customerAddress: customerAddress ?? this.customerAddress,
        isRated: isRated ?? this.isRated,
        branchName: branchName ?? this.branchName,
        category: category ?? this.category,
        type: type ?? this.type,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        itemTotalPrice: itemTotalPrice ?? this.itemTotalPrice,
        totalItems: totalItems ?? this.totalItems,
        totalPrice: totalPrice ?? this.totalPrice,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        vat: vat ?? this.vat,
        operationFee: operationFee ?? this.operationFee,
        note: note ?? this.note,
        recording: recording ?? this.recording,
        status: status ?? this.status,
        invoice: invoice ?? this.invoice,
        pickupInvoice: pickupInvoice ?? this.pickupInvoice,
        countDownStart: countDownStart ?? this.countDownStart,
        countDownEnd: countDownEnd ?? this.countDownEnd,
        customerAvailability: customerAvailability ?? this.customerAvailability,
        code: code ?? this.code,
        branchLat: branchLat ?? this.branchLat,
        branchLng: branchLng ?? this.branchLng,
        customerLat: customerLat ?? this.customerLat,
        customerLng: customerLng ?? this.customerLng,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        service: service ?? this.service,
        customer: customer ?? this.customer,
        orderStatuses: orderStatuses ?? this.orderStatuses,
        orderDeliveries: orderDeliveries ?? this.orderDeliveries,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        customerId: json["customer_id"],
        serviceId: json["service_id"],
        categoryId: json["category_id"],
        serviceTimingId: json["service_timing_id"],
        branchId: json["branch_id"],
        country: json["country"],
        city: json["city"],
        area: json["area"],
        shopAddress: json["shop_address"],
        customerAddress: json["customer_address"],
        isRated: json["is_rated"],
        branchName: json["branch_name"],
        category: json["category"],
        type: json["type"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        itemTotalPrice: json["item_total_price"]?.toDouble(),
        totalItems: json["total_items"],
        totalPrice: json["total_price"]?.toDouble(),
        deliveryFee: json["delivery_fee"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
        operationFee: json["operation_fee"]?.toDouble(),
        note: json["note"],
        recording: json["recording"],
        status: json["status"],
        invoice: json["invoice"],
        pickupInvoice: json["pickup_invoice"],
        countDownStart: json["count_down_start"] == null
            ? null
            : DateTime.parse(json["count_down_start"]),
        countDownEnd: json["count_down_end"] == null
            ? null
            : DateTime.parse(json["count_down_end"]),
        customerAvailability: json["customer_availability"],
        code: json["code"],
        branchLat: json["branch_lat"]?.toDouble(),
        branchLng: json["branch_lng"]?.toDouble(),
        customerLat: json["customer_lat"]?.toDouble(),
        customerLng: json["customer_lng"]?.toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        orderStatuses: json["order_statuses"] == null
            ? []
            : List<OrderStatus>.from(
                json["order_statuses"]!.map((x) => OrderStatus.fromJson(x))),
        orderDeliveries: json["order_deliveries"] == null
            ? null
            : OrderDeliveries.fromJson(json["order_deliveries"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "service_id": serviceId,
        "category_id": categoryId,
        "service_timing_id": serviceTimingId,
        "branch_id": branchId,
        "country": country,
        "city": city,
        "area": area,
        "shop_address": shopAddress,
        "customer_address": customerAddress,
        "is_rated": isRated,
        "branch_name": branchName,
        "category": category,
        "type": type,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "item_total_price": itemTotalPrice,
        "total_items": totalItems,
        "total_price": totalPrice,
        "delivery_fee": deliveryFee,
        "vat": vat,
        "operation_fee": operationFee,
        "note": note,
        "recording": recording,
        "status": status,
        "invoice": invoice,
        "pickup_invoice": pickupInvoice,
        "count_down_start": countDownStart?.toIso8601String(),
        "count_down_end": countDownEnd?.toIso8601String(),
        "customer_availability": customerAvailability,
        "code": code,
        "branch_lat": branchLat,
        "branch_lng": branchLng,
        "customer_lat": customerLat,
        "customer_lng": customerLng,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "service": service?.toJson(),
        "customer": customer?.toJson(),
        "order_statuses": orderStatuses == null
            ? []
            : List<dynamic>.from(orderStatuses!.map((x) => x.toJson())),
        "order_deliveries": orderDeliveries?.toJson(),
      };
}

class Customer {
  int? userId;
  String? mobileNumber;
  CustomerUser? user;

  Customer({
    this.userId,
    this.mobileNumber,
    this.user,
  });

  Customer copyWith({
    int? userId,
    String? mobileNumber,
    CustomerUser? user,
  }) =>
      Customer(
        userId: userId ?? this.userId,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        user: user ?? this.user,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        userId: json["user_id"],
        mobileNumber: json["mobile_number"],
        user: json["user"] == null ? null : CustomerUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "mobile_number": mobileNumber,
        "user": user?.toJson(),
      };
}

class CustomerUser {
  int? id;
  String? firstName;
  String? lastName;
  String? image;

  CustomerUser({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
  });

  CustomerUser copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? image,
  }) =>
      CustomerUser(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        image: image ?? this.image,
      );

  factory CustomerUser.fromJson(Map<String, dynamic> json) => CustomerUser(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
      };
}

class OrderDeliveries {
  int? id;
  int? orderId;
  int? deliveryAgentId;
  String? deliveryType;
  double? cost;
  DateTime? deliveryTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  OrderDeliveriesUser? user;
  DeliveryAgent? deliveryAgent;

  OrderDeliveries({
    this.id,
    this.orderId,
    this.deliveryAgentId,
    this.deliveryType,
    this.cost,
    this.deliveryTime,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.deliveryAgent,
  });

  OrderDeliveries copyWith({
    int? id,
    int? orderId,
    int? deliveryAgentId,
    String? deliveryType,
    double? cost,
    DateTime? deliveryTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    OrderDeliveriesUser? user,
    DeliveryAgent? deliveryAgent,
  }) =>
      OrderDeliveries(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        deliveryAgentId: deliveryAgentId ?? this.deliveryAgentId,
        deliveryType: deliveryType ?? this.deliveryType,
        cost: cost ?? this.cost,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
        deliveryAgent: deliveryAgent ?? this.deliveryAgent,
      );

  factory OrderDeliveries.fromJson(Map<String, dynamic> json) =>
      OrderDeliveries(
        id: json["id"],
        orderId: json["order_id"],
        deliveryAgentId: json["delivery_agent_id"],
        deliveryType: json["delivery_type"],
        cost: json["cost"]?.toDouble(),
        deliveryTime: json["delivery_time"] == null
            ? null
            : DateTime.parse(json["delivery_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null
            ? null
            : OrderDeliveriesUser.fromJson(json["user"]),
        deliveryAgent: json["delivery_agent"] == null
            ? null
            : DeliveryAgent.fromJson(json["delivery_agent"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "delivery_agent_id": deliveryAgentId,
        "delivery_type": deliveryType,
        "cost": cost,
        "delivery_time": deliveryTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "delivery_agent": deliveryAgent?.toJson(),
      };
}

class DeliveryAgent {
  String? mobileNumber;
  int? deliveryAgentId;

  DeliveryAgent({
    this.mobileNumber,
    this.deliveryAgentId,
  });

  DeliveryAgent copyWith({
    String? mobileNumber,
    int? deliveryAgentId,
  }) =>
      DeliveryAgent(
        mobileNumber: mobileNumber ?? this.mobileNumber,
        deliveryAgentId: deliveryAgentId ?? this.deliveryAgentId,
      );

  factory DeliveryAgent.fromJson(Map<String, dynamic> json) => DeliveryAgent(
        mobileNumber: json["mobile_number"],
        deliveryAgentId: json["delivery_agent_id"],
      );

  Map<String, dynamic> toJson() => {
        "mobile_number": mobileNumber,
        "delivery_agent_id": deliveryAgentId,
      };
}

class OrderDeliveriesUser {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  dynamic userName;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderDeliveriesUser({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.userName,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  OrderDeliveriesUser copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? image,
    dynamic userName,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      OrderDeliveriesUser(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        image: image ?? this.image,
        userName: userName ?? this.userName,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory OrderDeliveriesUser.fromJson(Map<String, dynamic> json) =>
      OrderDeliveriesUser(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        userName: json["user_name"],
        role: json["role"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "user_name": userName,
        "role": role,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class OrderStatus {
  int? id;
  int? orderId;
  String? status;
  DateTime? statusTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderStatus({
    this.id,
    this.orderId,
    this.status,
    this.statusTime,
    this.createdAt,
    this.updatedAt,
  });

  OrderStatus copyWith({
    int? id,
    int? orderId,
    String? status,
    DateTime? statusTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      OrderStatus(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        status: status ?? this.status,
        statusTime: statusTime ?? this.statusTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        id: json["id"],
        orderId: json["order_id"],
        status: json["status"],
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
        "status_time": statusTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Service {
  int? id;
  String? serviceName;
  String? serviceNameArabic;
  int? deliveryFee;
  int? operationFee;

  Service({
    this.id,
    this.serviceName,
    this.serviceNameArabic,
    this.deliveryFee,
    this.operationFee,
  });

  Service copyWith({
    int? id,
    String? serviceName,
    String? serviceNameArabic,
    int? deliveryFee,
    int? operationFee,
  }) =>
      Service(
        id: id ?? this.id,
        serviceName: serviceName ?? this.serviceName,
        serviceNameArabic: serviceNameArabic ?? this.serviceNameArabic,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        operationFee: operationFee ?? this.operationFee,
      );

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        serviceName: json["service_name"],
        serviceNameArabic: json["service_name_arabic"],
        deliveryFee: json["delivery_fee"],
        operationFee: json["operation_fee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "service_name_arabic": serviceNameArabic,
        "delivery_fee": deliveryFee,
        "operation_fee": operationFee,
      };
}