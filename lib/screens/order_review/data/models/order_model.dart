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
  int? deliveryAgentId;
  String? country;
  String? city;
  String? area;
  String? pickupFrom;
  String? deliveredTo;
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
  DateTime? startTime;
  DateTime? endTime;
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
  List<OrderDelivery>? orderDeliveries;

  Order({
    this.id,
    this.customerId,
    this.serviceId,
    this.categoryId,
    this.serviceTimingId,
    this.branchId,
    this.deliveryAgentId,
    this.country,
    this.city,
    this.area,
    this.pickupFrom,
    this.deliveredTo,
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
    this.startTime,
    this.endTime,
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

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        customerId: json["customer_id"],
        serviceId: json["service_id"],
        categoryId: json["category_id"],
        serviceTimingId: json["service_timing_id"],
        branchId: json["branch_id"],
        deliveryAgentId: json["delivery_agent_id"],
        country: json["country"],
        city: json["city"],
        area: json["area"],
        pickupFrom: json["pickup_from"],
        deliveredTo: json["delivered_to"],
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
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
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
            ? []
            : List<OrderDelivery>.from(json["order_deliveries"]!
                .map((x) => OrderDelivery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "service_id": serviceId,
        "category_id": categoryId,
        "service_timing_id": serviceTimingId,
        "branch_id": branchId,
        "delivery_agent_id": deliveryAgentId,
        "country": country,
        "city": city,
        "area": area,
        "pickup_from": pickupFrom,
        "delivered_to": deliveredTo,
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
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
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
        "order_deliveries": orderDeliveries == null
            ? []
            : List<dynamic>.from(orderDeliveries!.map((x) => x.toJson())),
      };
}

class Customer {
  int? userId;
  String? mobileNumber;
  User? user;

  Customer({
    this.userId,
    this.mobileNumber,
    this.user,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        userId: json["user_id"],
        mobileNumber: json["mobile_number"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "mobile_number": mobileNumber,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? image;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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

class OrderDelivery {
  int? id;
  int? orderId;
  int? deliveryAgentId;
  String? deliveryType;
  double? cost;
  dynamic deliveryTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  DeliveryAgent? deliveryAgent;

  OrderDelivery({
    this.id,
    this.orderId,
    this.deliveryAgentId,
    this.deliveryType,
    this.cost,
    this.deliveryTime,
    this.createdAt,
    this.updatedAt,
    this.deliveryAgent,
  });

  factory OrderDelivery.fromJson(Map<String, dynamic> json) => OrderDelivery(
        id: json["id"],
        orderId: json["order_id"],
        deliveryAgentId: json["delivery_agent_id"],
        deliveryType: json["delivery_type"],
        cost: json["cost"]?.toDouble(),
        deliveryTime: json["delivery_time"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "delivery_time": deliveryTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "delivery_agent": deliveryAgent?.toJson(),
      };
}

class DeliveryAgent {
  int? id;
  String? mobileNumber;
  DateTime? dateOfBirth;
  String? identityType;
  String? identityNumber;
  String? identityImage;
  int? deliveryAgentId;
  double? latitude;
  double? longitude;
  String? status;
  String? activityStatus;
  String? bagsStatus;
  String? securityFeesStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeliveryAgent({
    this.id,
    this.mobileNumber,
    this.dateOfBirth,
    this.identityType,
    this.identityNumber,
    this.identityImage,
    this.deliveryAgentId,
    this.latitude,
    this.longitude,
    this.status,
    this.activityStatus,
    this.bagsStatus,
    this.securityFeesStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryAgent.fromJson(Map<String, dynamic> json) => DeliveryAgent(
        id: json["id"],
        mobileNumber: json["mobile_number"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        identityType: json["identity_type"],
        identityNumber: json["identity_number"],
        identityImage: json["identity_image"],
        deliveryAgentId: json["delivery_agent_id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        status: json["status"],
        activityStatus: json["activity_status"],
        bagsStatus: json["bags_status"],
        securityFeesStatus: json["security_fees_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mobile_number": mobileNumber,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "identity_type": identityType,
        "identity_number": identityNumber,
        "identity_image": identityImage,
        "delivery_agent_id": deliveryAgentId,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "activity_status": activityStatus,
        "bags_status": bagsStatus,
        "security_fees_status": securityFeesStatus,
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

  Service({
    this.id,
    this.serviceName,
    this.serviceNameArabic,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        serviceName: json["service_name"],
        serviceNameArabic: json["service_name_arabic"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "service_name_arabic": serviceNameArabic,
      };
}
