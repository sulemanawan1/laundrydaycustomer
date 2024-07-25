
// To parse this JSON data, do
//
//     final nearestLaundryModel = nearestLaundryModelFromJson(jsonString);

import 'dart:convert';

NearestLaundryModel nearestLaundryModelFromJson(String str) =>
    NearestLaundryModel.fromJson(json.decode(str));

String nearestLaundryModelToJson(NearestLaundryModel data) =>
    json.encode(data.toJson());

class NearestLaundryModel {
  bool? success;
  String? message;
  Data? data;

  NearestLaundryModel({
    this.success,
    this.message,
    this.data,
  });

  NearestLaundryModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      NearestLaundryModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory NearestLaundryModel.fromJson(Map<String, dynamic> json) =>
      NearestLaundryModel(
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
  int? id;
  String? name;
  String? arabicName;
  String? type;
  int? branches;
  String? taxNumber;
  String? commercialRegistrationNo;
  String? commercialRegistrationImage;
  String? logo;
  int? isCentralLaundry;
  String? subscriptionStatus;
  String? verificationStatus;
  int? totalOrders;
  int? rating;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? distance;
  String? duration;
  Branch? branch;
  List<Service>? services;

  Data({
    this.id,
    this.name,
    this.arabicName,
    this.type,
    this.branches,
    this.taxNumber,
    this.commercialRegistrationNo,
    this.commercialRegistrationImage,
    this.logo,
    this.isCentralLaundry,
    this.subscriptionStatus,
    this.verificationStatus,
    this.totalOrders,
    this.rating,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.distance,
    this.duration,
    this.branch,
    this.services,
  });

  Data copyWith({
    int? id,
    String? name,
    String? arabicName,
    String? type,
    int? branches,
    String? taxNumber,
    String? commercialRegistrationNo,
    String? commercialRegistrationImage,
    String? logo,
    int? isCentralLaundry,
    String? subscriptionStatus,
    String? verificationStatus,
    int? totalOrders,
    int? rating,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? distance,
    String? duration,
    Branch? branch,
    List<Service>? services,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        arabicName: arabicName ?? this.arabicName,
        type: type ?? this.type,
        branches: branches ?? this.branches,
        taxNumber: taxNumber ?? this.taxNumber,
        commercialRegistrationNo:
            commercialRegistrationNo ?? this.commercialRegistrationNo,
        commercialRegistrationImage:
            commercialRegistrationImage ?? this.commercialRegistrationImage,
        logo: logo ?? this.logo,
        isCentralLaundry: isCentralLaundry ?? this.isCentralLaundry,
        subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
        verificationStatus: verificationStatus ?? this.verificationStatus,
        totalOrders: totalOrders ?? this.totalOrders,
        rating: rating ?? this.rating,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
        branch: branch ?? this.branch,
        services: services ?? this.services,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        type: json["type"],
        branches: json["branches"],
        taxNumber: json["tax_number"],
        commercialRegistrationNo: json["commercial_registration_no"],
        commercialRegistrationImage: json["commercial_registration_image"],
        logo: json["logo"],
        isCentralLaundry: json["is_central_laundry"],
        subscriptionStatus: json["subscription_status"],
        verificationStatus: json["verification_status"],
        totalOrders: json["total_orders"],
        rating: json["rating"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        distance: json["distance"],
        duration: json["duration"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        services: json["services"] == null
            ? []
            : List<Service>.from(
                json["services"]!.map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "type": type,
        "branches": branches,
        "tax_number": taxNumber,
        "commercial_registration_no": commercialRegistrationNo,
        "commercial_registration_image": commercialRegistrationImage,
        "logo": logo,
        "is_central_laundry": isCentralLaundry,
        "subscription_status": subscriptionStatus,
        "verification_status": verificationStatus,
        "total_orders": totalOrders,
        "rating": rating,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "distance": distance,
        "duration": duration,
        "branch": branch?.toJson(),
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class Branch {
  int? id;
  int? countryId;
  int? regionId;
  int? cityId;
  String? district;
  int? districtId;
  String? area;
  String? address;
  String? postalCode;
  String? googleMapAddress;
  double? lat;
  double? lng;
  String? licenceImage;
  String? openTime;
  String? closeTime;
  int? rating;
  String? verificationStatus;
  int? laundryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Branch({
    this.id,
    this.countryId,
    this.regionId,
    this.cityId,
    this.district,
    this.districtId,
    this.area,
    this.address,
    this.postalCode,
    this.googleMapAddress,
    this.lat,
    this.lng,
    this.licenceImage,
    this.openTime,
    this.closeTime,
    this.rating,
    this.verificationStatus,
    this.laundryId,
    this.createdAt,
    this.updatedAt,
  });

  Branch copyWith({
    int? id,
    int? countryId,
    int? regionId,
    int? cityId,
    String? district,
    int? districtId,
    String? area,
    String? address,
    String? postalCode,
    String? googleMapAddress,
    double? lat,
    double? lng,
    String? licenceImage,
    String? openTime,
    String? closeTime,
    int? rating,
    String? verificationStatus,
    int? laundryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Branch(
        id: id ?? this.id,
        countryId: countryId ?? this.countryId,
        regionId: regionId ?? this.regionId,
        cityId: cityId ?? this.cityId,
        district: district ?? this.district,
        districtId: districtId ?? this.districtId,
        area: area ?? this.area,
        address: address ?? this.address,
        postalCode: postalCode ?? this.postalCode,
        googleMapAddress: googleMapAddress ?? this.googleMapAddress,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        licenceImage: licenceImage ?? this.licenceImage,
        openTime: openTime ?? this.openTime,
        closeTime: closeTime ?? this.closeTime,
        rating: rating ?? this.rating,
        verificationStatus: verificationStatus ?? this.verificationStatus,
        laundryId: laundryId ?? this.laundryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        countryId: json["country_id"],
        regionId: json["region_id"],
        cityId: json["city_id"],
        district: json["district"],
        districtId: json["district_id"],
        area: json["area"],
        address: json["address"],
        postalCode: json["postal_code"],
        googleMapAddress: json["google_map_address"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        licenceImage: json["licence_image"],
        openTime: json["open_time"],
        closeTime: json["close_time"],
        rating: json["rating"],
        verificationStatus: json["verification_status"],
        laundryId: json["laundry_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "region_id": regionId,
        "city_id": cityId,
        "district": district,
        "district_id": districtId,
        "area": area,
        "address": address,
        "postal_code": postalCode,
        "google_map_address": googleMapAddress,
        "lat": lat,
        "lng": lng,
        "licence_image": licenceImage,
        "open_time": openTime,
        "close_time": closeTime,
        "rating": rating,
        "verification_status": verificationStatus,
        "laundry_id": laundryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Service {
  int? id;
  String? serviceName;
  String? serviceNameArabic;
  String? serviceDescription;
  String? serviceDescriptionArabic;
  String? serviceImage;
  double? deliveryFee;
  double? operationFee;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  Service({
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
    this.pivot,
  });

  Service copyWith({
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
    Pivot? pivot,
  }) =>
      Service(
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
        pivot: pivot ?? this.pivot,
      );

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
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
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  int? laundryId;
  int? serviceId;

  Pivot({
    this.laundryId,
    this.serviceId,
  });

  Pivot copyWith({
    int? laundryId,
    int? serviceId,
  }) =>
      Pivot(
        laundryId: laundryId ?? this.laundryId,
        serviceId: serviceId ?? this.serviceId,
      );

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        laundryId: json["laundry_id"],
        serviceId: json["service_id"],
      );

  Map<String, dynamic> toJson() => {
        "laundry_id": laundryId,
        "service_id": serviceId,
      };
}
