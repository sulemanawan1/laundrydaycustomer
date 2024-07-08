// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromMap(jsonString);

import 'dart:convert';

ServiceModel serviceModelFromMap(String str) =>
    ServiceModel.fromMap(json.decode(str));

String serviceModelToMap(ServiceModel data) => json.encode(data.toMap());

class ServiceModel {
  final String? message;
  final List<Datum>? data;

  ServiceModel({
    this.message,
    this.data,
  });

  ServiceModel copyWith({
    String? message,
    List<Datum>? data,
  }) =>
      ServiceModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ServiceModel.fromMap(Map<String, dynamic> json) => ServiceModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  final int? id;
  final String? serviceName;
  final String? serviceNameArabic;
  final String? serviceDescription;
  final String? serviceDescriptionArabic;
  final String? serviceImage;
  final double? deliveryFee;
  final double? operationFee;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum({
    this.id,
    this.serviceName,
    this.serviceNameArabic,
    this.serviceDescription,
    this.serviceDescriptionArabic,
    this.serviceImage,
    this.deliveryFee,
    this.operationFee,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  Datum copyWith({
    int? id,
    String? serviceName,
    String? serviceNameArabic,
    String? serviceDescription,
    String? serviceDescriptionArabic,
    String? serviceImage,
    double? deliveryFee,
    double? operationFee,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        serviceName: serviceName ?? this.serviceName,
        serviceNameArabic: serviceNameArabic ?? this.serviceNameArabic,
        serviceDescription: serviceDescription ?? this.serviceDescription,
        serviceDescriptionArabic:
            serviceDescriptionArabic ?? this.serviceDescriptionArabic,
        serviceImage: serviceImage ?? this.serviceImage,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        operationFee: operationFee ?? this.operationFee,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        serviceName: json["service_name"],
        serviceNameArabic: json["service_name_arabic"],
        serviceDescription: json["service_description"],
        serviceDescriptionArabic: json["service_description_arabic"],
        serviceImage: json["service_image"],
        deliveryFee: json["delivery_fee"]?.toDouble(),
        operationFee: json["operation_fee"]?.toDouble(),
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "service_name": serviceName,
        "service_name_arabic": serviceNameArabic,
        "service_description": serviceDescription,
        "service_description_arabic": serviceDescriptionArabic,
        "service_image": serviceImage,
        "delivery_fee": deliveryFee,
        "operation_fee": operationFee,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
