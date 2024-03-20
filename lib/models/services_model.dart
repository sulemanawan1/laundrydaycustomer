// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

import 'dart:convert';

import 'package:laundryday/models/service_carousel_images.dart';

ServicesModel servicesModelFromJson(String str) =>
    ServicesModel.fromJson(json.decode(str));

String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());

class ServicesModel {
  int id;
  double operationFee;
  double deliveryFee;
  double vat;
  String name;
  String image;
  List<ServiceCarouselImage> images;

  ServicesModel({
    required this.vat,
    required this.id,
    required this.name,
    required this.image,
    required this.deliveryFee,
    required this.operationFee,
    required this.images,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        vat: json["vat"],
        id: json["id"],
        deliveryFee: json['delivery_fee'],
        operationFee: json['operation_fee'],
        name: json["name"],
        image: json["image"],
        images: List<ServiceCarouselImage>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "vat": vat,
        "id": id,
        "name": name,
        "image": image,
        "operation_fee": operationFee,
        "delivery_fee": deliveryFee,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
