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
  int? userId;
  int? paidBy;
  int? serviceId;
  int? categoryId;
  int? serviceTimingId;
  int? branchId;
  String? country;
  String? city;
  String? area;
  String? shopAddress;
  String? customerAddress;
  String? branchName;
  String? category;
  String? type;
  String? deliveryType;
  String? paymentStatus;
  String? paymentMethod;
  String? paymentOption;
  DateTime? paymentAt;
  double? itemTotalPrice;
  int? totalItems;
  double? totalPrice;
  double? deliveryFee;
  double? vat;
  double? operationFee;
  String? note;
  String? recording;
  String? status;
  String? pickupInvoice;
  String? paymentInvoice;
  DateTime? countDownStart;
  DateTime? countDownEnd;
  String? firstTripStatus;
  String? secondTripStatus;
  String? code;
  double? branchLat;
  double? branchLng;
  double? customerLat;
  double? customerLng;
  double? additionalOperationFee;
  double? additionalDeliveryFee;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  Service? service;
  Customer? customer;
  List<OrderStatus>? orderStatuses;
  List<Item>? items;
  OrderDeliveries? orderDeliveries;

  Order({
    this.id,
    this.userId,
    this.paidBy,
    this.serviceId,
    this.categoryId,
    this.serviceTimingId,
    this.branchId,
    this.country,
    this.city,
    this.area,
    this.shopAddress,
    this.customerAddress,
    this.branchName,
    this.category,
    this.type,
    this.deliveryType,
    this.paymentStatus,
    this.paymentMethod,
    this.paymentOption,
    this.paymentAt,
    this.itemTotalPrice,
    this.totalItems,
    this.totalPrice,
    this.deliveryFee,
    this.vat,
    this.operationFee,
    this.note,
    this.recording,
    this.status,
    this.pickupInvoice,
    this.paymentInvoice,
    this.countDownStart,
    this.countDownEnd,
    this.firstTripStatus,
    this.secondTripStatus,
    this.code,
    this.branchLat,
    this.branchLng,
    this.customerLat,
    this.customerLng,
    this.additionalOperationFee,
    this.additionalDeliveryFee,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.customer,
    this.orderStatuses,
    this.items,
    this.orderDeliveries,
  });

  Order copyWith({
    int? id,
    int? userId,
    int? paidBy,
    int? serviceId,
    int? categoryId,
    int? serviceTimingId,
    int? branchId,
    String? country,
    String? city,
    String? area,
    String? shopAddress,
    String? customerAddress,
    String? branchName,
    String? category,
    String? type,
    String? deliveryType,
    String? paymentStatus,
    String? paymentMethod,
    String? paymentOption,
    DateTime? paymentAt,
    double? itemTotalPrice,
    int? totalItems,
    double? totalPrice,
    bool? itemsExempt,
    double? deliveryFee,
    double? vat,
    double? operationFee,
    String? note,
    String? recording,
    String? status,
    String? pickupInvoice,
    String? paymentInvoice,
    DateTime? countDownStart,
    DateTime? countDownEnd,
    String? firstTripStatus,
    String? secondTripStatus,
    String? code,
    double? branchLat,
    double? branchLng,
    double? customerLat,
    double? customerLng,
    double? additionalOperationFee,
    double? additionalDeliveryFee,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
    Service? service,
    Customer? customer,
    List<OrderStatus>? orderStatuses,
    List<Item>? items,
    OrderDeliveries? orderDeliveries,
  }) =>
      Order(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        paidBy: paidBy ?? this.paidBy,
        serviceId: serviceId ?? this.serviceId,
        categoryId: categoryId ?? this.categoryId,
        serviceTimingId: serviceTimingId ?? this.serviceTimingId,
        branchId: branchId ?? this.branchId,
        country: country ?? this.country,
        city: city ?? this.city,
        area: area ?? this.area,
        shopAddress: shopAddress ?? this.shopAddress,
        customerAddress: customerAddress ?? this.customerAddress,
        branchName: branchName ?? this.branchName,
        category: category ?? this.category,
        type: type ?? this.type,
        deliveryType: deliveryType ?? this.deliveryType,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentOption: paymentOption ?? this.paymentOption,
        paymentAt: paymentAt ?? this.paymentAt,
        itemTotalPrice: itemTotalPrice ?? this.itemTotalPrice,
        totalItems: totalItems ?? this.totalItems,
        totalPrice: totalPrice ?? this.totalPrice,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        vat: vat ?? this.vat,
        operationFee: operationFee ?? this.operationFee,
        note: note ?? this.note,
        recording: recording ?? this.recording,
        status: status ?? this.status,
        pickupInvoice: pickupInvoice ?? this.pickupInvoice,
        paymentInvoice: paymentInvoice ?? this.paymentInvoice,
        countDownStart: countDownStart ?? this.countDownStart,
        countDownEnd: countDownEnd ?? this.countDownEnd,
        firstTripStatus: firstTripStatus ?? this.firstTripStatus,
        secondTripStatus: secondTripStatus ?? this.secondTripStatus,
        code: code ?? this.code,
        branchLat: branchLat ?? this.branchLat,
        branchLng: branchLng ?? this.branchLng,
        customerLat: customerLat ?? this.customerLat,
        customerLng: customerLng ?? this.customerLng,
        additionalOperationFee:
            additionalOperationFee ?? this.additionalOperationFee,
        additionalDeliveryFee:
            additionalDeliveryFee ?? this.additionalDeliveryFee,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        service: service ?? this.service,
        customer: customer ?? this.customer,
        orderStatuses: orderStatuses ?? this.orderStatuses,
        items: items ?? this.items,
        orderDeliveries: orderDeliveries ?? this.orderDeliveries,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        paidBy: json["paid_by"],
        serviceId: json["service_id"],
        categoryId: json["category_id"],
        serviceTimingId: json["service_timing_id"],
        branchId: json["branch_id"],
        country: json["country"],
        city: json["city"],
        area: json["area"],
        shopAddress: json["shop_address"],
        customerAddress: json["customer_address"],
        branchName: json["branch_name"],
        category: json["category"],
        type: json["type"],
        deliveryType: json["delivery_type"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        paymentOption: json["payment_option"],
        paymentAt: json["payment_at"] == null
            ? null
            : DateTime.parse(json["payment_at"]),
        itemTotalPrice: json["item_total_price"]?.toDouble(),
        totalItems: json["total_items"],
        totalPrice: json["total_price"]?.toDouble(),
        deliveryFee: json["delivery_fee"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
        operationFee: json["operation_fee"]?.toDouble(),
        note: json["note"],
        recording: json["recording"],
        status: json["status"],
        pickupInvoice: json["pickup_invoice"],
        paymentInvoice: json["payment_invoice"],
        countDownStart: json["count_down_start"] == null
            ? null
            : DateTime.parse(json["count_down_start"]),
        countDownEnd: json["count_down_end"] == null
            ? null
            : DateTime.parse(json["count_down_end"]),
        firstTripStatus: json["first_trip_status"],
        secondTripStatus: json["second_trip_status"],
        code: json["code"],
        branchLat: json["branch_lat"]?.toDouble(),
        branchLng: json["branch_lng"]?.toDouble(),
        customerLat: json["customer_lat"]?.toDouble(),
        customerLng: json["customer_lng"]?.toDouble(),
        additionalOperationFee: json["additional_operation_fee"]?.toDouble(),
        additionalDeliveryFee: json["additional_delivery_fee"]?.toDouble(),
        message: json["message"],
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
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        orderDeliveries: json["order_deliveries"] == null
            ? null
            : OrderDeliveries.fromJson(json["order_deliveries"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "paid_by": paidBy,
        "service_id": serviceId,
        "category_id": categoryId,
        "service_timing_id": serviceTimingId,
        "branch_id": branchId,
        "country": country,
        "city": city,
        "area": area,
        "shop_address": shopAddress,
        "customer_address": customerAddress,
        "branch_name": branchName,
        "category": category,
        "type": type,
        "delivery_type": deliveryType,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "payment_option": paymentOption,
        "payment_at": paymentAt?.toIso8601String(),
        "item_total_price": itemTotalPrice,
        "total_items": totalItems,
        "total_price": totalPrice,
        "delivery_fee": deliveryFee,
        "vat": vat,
        "operation_fee": operationFee,
        "note": note,
        "recording": recording,
        "status": status,
        "pickup_invoice": pickupInvoice,
        "payment_invoice": paymentInvoice,
        "count_down_start": countDownStart?.toIso8601String(),
        "count_down_end": countDownEnd?.toIso8601String(),
        "first_trip_status": firstTripStatus,
        "second_trip_status": secondTripStatus,
        "code": code,
        "branch_lat": branchLat,
        "branch_lng": branchLng,
        "customer_lat": customerLat,
        "customer_lng": customerLng,
        "additional_operation_fee": additionalOperationFee,
        "additional_delivery_fee": additionalDeliveryFee,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "service": service?.toJson(),
        "customer": customer?.toJson(),
        "order_statuses": orderStatuses == null
            ? []
            : List<dynamic>.from(orderStatuses!.map((x) => x.toJson())),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "order_deliveries": orderDeliveries?.toJson(),
      };
}

class Customer {
  int? id;
  String? mobileNumber;
  String? firstName;
  String? lastName;
  String? image;
  String? role;

  Customer({
    this.id,
    this.mobileNumber,
    this.firstName,
    this.lastName,
    this.image,
    this.role,
  });

  Customer copyWith({
    int? id,
    String? mobileNumber,
    String? firstName,
    String? lastName,
    String? image,
    String? role,
  }) =>
      Customer(
        id: id ?? this.id,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        image: image ?? this.image,
        role: role ?? this.role,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        mobileNumber: json["mobile_number"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mobile_number": mobileNumber,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "role": role,
      };
}

class Item {
  int? id;
  int? orderId;
  int? itemVariationId;
  double? price;
  int? quantity;
  double? total;
  String? customItemName;
  int? excessCount;
  double? excessDeliveryFees;
  DateTime? createdAt;
  DateTime? updatedAt;
  ItemVariations? itemVariations;

  Item({
    this.id,
    this.orderId,
    this.itemVariationId,
    this.price,
    this.quantity,
    this.total,
    this.customItemName,
    this.excessCount,
    this.excessDeliveryFees,
    this.createdAt,
    this.updatedAt,
    this.itemVariations,
  });

  Item copyWith({
    int? id,
    int? orderId,
    int? itemVariationId,
    double? price,
    int? quantity,
    double? total,
    String? customItemName,
    int? excessCount,
    double? excessDeliveryFees,
    DateTime? createdAt,
    DateTime? updatedAt,
    ItemVariations? itemVariations,
  }) =>
      Item(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        itemVariationId: itemVariationId ?? this.itemVariationId,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
        customItemName: customItemName ?? this.customItemName,
        excessCount: excessCount ?? this.excessCount,
        excessDeliveryFees: excessDeliveryFees ?? this.excessDeliveryFees,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        itemVariations: itemVariations ?? this.itemVariations,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        orderId: json["order_id"],
        itemVariationId: json["item_variation_id"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        total: json["total"]?.toDouble(),
        customItemName: json["custom_item_name"],
        excessCount: json["excess_count"],
        excessDeliveryFees: json["excess_delivery_fees"]?.toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        itemVariations: json["item_variations"] == null
            ? null
            : ItemVariations.fromJson(json["item_variations"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "item_variation_id": itemVariationId,
        "price": price,
        "quantity": quantity,
        "total": total,
        "custom_item_name": customItemName,
        "excess_count": excessCount,
        "excess_delivery_fees": excessDeliveryFees,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "item_variations": itemVariations?.toJson(),
      };
}

class ItemVariations {
  int? id;
  String? name;

  ItemVariations({
    this.id,
    this.name,
  });

  ItemVariations copyWith({
    int? id,
    String? name,
  }) =>
      ItemVariations(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory ItemVariations.fromJson(Map<String, dynamic> json) => ItemVariations(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
  Customer? user;
  DeliveryAgentVechileInfo? deliveryAgentVechileInfo;

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
    this.deliveryAgentVechileInfo,
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
    Customer? user,
    DeliveryAgentVechileInfo? deliveryAgentVechileInfo,
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
        deliveryAgentVechileInfo:
            deliveryAgentVechileInfo ?? this.deliveryAgentVechileInfo,
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
        user: json["user"] == null ? null : Customer.fromJson(json["user"]),
        deliveryAgentVechileInfo: json["delivery_agent_vechile_info"] == null
            ? null
            : DeliveryAgentVechileInfo.fromJson(
                json["delivery_agent_vechile_info"]),
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
        "delivery_agent_vechile_info": deliveryAgentVechileInfo?.toJson(),
      };
}

class DeliveryAgentVechileInfo {
  String? model;
  String? brand;
  int? deliveryAgentId;
  String? plateNumber;
  String? classification;

  DeliveryAgentVechileInfo({
    this.model,
    this.brand,
    this.deliveryAgentId,
    this.plateNumber,
    this.classification,
  });

  DeliveryAgentVechileInfo copyWith({
    String? model,
    String? brand,
    int? deliveryAgentId,
    String? plateNumber,
    String? classification,
  }) =>
      DeliveryAgentVechileInfo(
        model: model ?? this.model,
        brand: brand ?? this.brand,
        deliveryAgentId: deliveryAgentId ?? this.deliveryAgentId,
        plateNumber: plateNumber ?? this.plateNumber,
        classification: classification ?? this.classification,
      );

  factory DeliveryAgentVechileInfo.fromJson(Map<String, dynamic> json) =>
      DeliveryAgentVechileInfo(
        model: json["model"],
        brand: json["brand"],
        deliveryAgentId: json["delivery_agent_id"],
        plateNumber: json["plate_number"],
        classification: json["classification"],
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "brand": brand,
        "delivery_agent_id": deliveryAgentId,
        "plate_number": plateNumber,
        "classification": classification,
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

class Service {
  int? id;
  String? serviceName;
  String? serviceNameArabic;
  double? deliveryFee;
  double? operationFee;

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
    double? deliveryFee,
    double? operationFee,
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
        deliveryFee: json["delivery_fee"]?.toDouble(),
        operationFee: json["operation_fee"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "service_name_arabic": serviceNameArabic,
        "delivery_fee": deliveryFee,
        "operation_fee": operationFee,
      };
}
