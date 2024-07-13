// To parse this JSON data, do
//
//     final deliveryAgentRegistrationModel = deliveryAgentRegistrationModelFromJson(jsonString);

import 'dart:convert';

DeliveryAgentRegistrationModel deliveryAgentRegistrationModelFromJson(
        String str) =>
    DeliveryAgentRegistrationModel.fromJson(json.decode(str));

String deliveryAgentRegistrationModelToJson(
        DeliveryAgentRegistrationModel data) =>
    json.encode(data.toJson());

class DeliveryAgentRegistrationModel {
  bool? success;
  String? message;
  DeliveryAgent? deliveryAgent;

  DeliveryAgentRegistrationModel({
    this.success,
    this.message,
    this.deliveryAgent,
  });

  DeliveryAgentRegistrationModel copyWith({
    bool? success,
    String? message,
    DeliveryAgent? deliveryAgent,
  }) =>
      DeliveryAgentRegistrationModel(
        success: success ?? this.success,
        message: message ?? this.message,
        deliveryAgent: deliveryAgent ?? this.deliveryAgent,
      );

  factory DeliveryAgentRegistrationModel.fromJson(Map<String, dynamic> json) =>
      DeliveryAgentRegistrationModel(
        success: json["success"],
        message: json["message"],
        deliveryAgent: json["delivery_agent"] == null
            ? null
            : DeliveryAgent.fromJson(json["delivery_agent"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
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
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  AddressInfo? addressInfo;
  VechileInfo? vechileInfo;

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
    this.createdAt,
    this.updatedAt,
    this.user,
    this.addressInfo,
    this.vechileInfo,
  });

  DeliveryAgent copyWith({
    int? id,
    String? mobileNumber,
    DateTime? dateOfBirth,
    String? identityType,
    String? identityNumber,
    String? identityImage,
    int? deliveryAgentId,
    double? latitude,
    double? longitude,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
    AddressInfo? addressInfo,
    VechileInfo? vechileInfo,
  }) =>
      DeliveryAgent(
        id: id ?? this.id,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        identityType: identityType ?? this.identityType,
        identityNumber: identityNumber ?? this.identityNumber,
        identityImage: identityImage ?? this.identityImage,
        deliveryAgentId: deliveryAgentId ?? this.deliveryAgentId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
        addressInfo: addressInfo ?? this.addressInfo,
        vechileInfo: vechileInfo ?? this.vechileInfo,
      );

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        addressInfo: json["address_info"] == null
            ? null
            : AddressInfo.fromJson(json["address_info"]),
        vechileInfo: json["vechile_info"] == null
            ? null
            : VechileInfo.fromJson(json["vechile_info"]),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "address_info": addressInfo?.toJson(),
        "vechile_info": vechileInfo?.toJson(),
      };
}

class AddressInfo {
  int? deliveryAgentId;
  int? countryId;
  int? regionId;
  int? cityId;
  int? districtId;
  City? country;
  City? city;
  City? region;
  District? district;

  AddressInfo({
    this.deliveryAgentId,
    this.countryId,
    this.regionId,
    this.cityId,
    this.districtId,
    this.country,
    this.city,
    this.region,
    this.district,
  });

  AddressInfo copyWith({
    int? deliveryAgentId,
    int? countryId,
    int? regionId,
    int? cityId,
    int? districtId,
    City? country,
    City? city,
    City? region,
    District? district,
  }) =>
      AddressInfo(
        deliveryAgentId: deliveryAgentId ?? this.deliveryAgentId,
        countryId: countryId ?? this.countryId,
        regionId: regionId ?? this.regionId,
        cityId: cityId ?? this.cityId,
        districtId: districtId ?? this.districtId,
        country: country ?? this.country,
        city: city ?? this.city,
        region: region ?? this.region,
        district: district ?? this.district,
      );

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
        deliveryAgentId: json["delivery_agent_id"],
        countryId: json["country_id"],
        regionId: json["region_id"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        country:
            json["country"] == null ? null : City.fromJson(json["country"]),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        region: json["region"] == null ? null : City.fromJson(json["region"]),
        district: json["district"] == null
            ? null
            : District.fromJson(json["district"]),
      );

  Map<String, dynamic> toJson() => {
        "delivery_agent_id": deliveryAgentId,
        "country_id": countryId,
        "region_id": regionId,
        "city_id": cityId,
        "district_id": districtId,
        "country": country?.toJson(),
        "city": city?.toJson(),
        "region": region?.toJson(),
        "district": district?.toJson(),
      };
}

class City {
  int? id;
  String? name;

  City({
    this.id,
    this.name,
  });

  City copyWith({
    int? id,
    String? name,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class District {
  int? id;
  String? name;
  double? lat;
  double? lng;

  District({
    this.id,
    this.name,
    this.lat,
    this.lng,
  });

  District copyWith({
    int? id,
    String? name,
    double? lat,
    double? lng,
  }) =>
      District(
        id: id ?? this.id,
        name: name ?? this.name,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lat": lat,
        "lng": lng,
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  dynamic userName;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.userName,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? image,
    dynamic userName,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        image: image ?? this.image,
        userName: userName ?? this.userName,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
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

class VechileInfo {
  int? id;
  String? serialNumber;
  String? type;
  String? classification;
  String? model;
  String? plateNumber;
  String? frontImage;
  String? rearImage;
  String? drivingLicenseImage;
  String? registrationImage;
  int? deliveryAgentId;
  DateTime? createdAt;
  DateTime? updatedAt;

  VechileInfo({
    this.id,
    this.serialNumber,
    this.type,
    this.classification,
    this.model,
    this.plateNumber,
    this.frontImage,
    this.rearImage,
    this.drivingLicenseImage,
    this.registrationImage,
    this.deliveryAgentId,
    this.createdAt,
    this.updatedAt,
  });

  VechileInfo copyWith({
    int? id,
    String? serialNumber,
    String? type,
    String? classification,
    String? model,
    String? plateNumber,
    String? frontImage,
    String? rearImage,
    String? drivingLicenseImage,
    String? registrationImage,
    int? deliveryAgentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      VechileInfo(
        id: id ?? this.id,
        serialNumber: serialNumber ?? this.serialNumber,
        type: type ?? this.type,
        classification: classification ?? this.classification,
        model: model ?? this.model,
        plateNumber: plateNumber ?? this.plateNumber,
        frontImage: frontImage ?? this.frontImage,
        rearImage: rearImage ?? this.rearImage,
        drivingLicenseImage: drivingLicenseImage ?? this.drivingLicenseImage,
        registrationImage: registrationImage ?? this.registrationImage,
        deliveryAgentId: deliveryAgentId ?? this.deliveryAgentId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory VechileInfo.fromJson(Map<String, dynamic> json) => VechileInfo(
        id: json["id"],
        serialNumber: json["serial_number"],
        type: json["type"],
        classification: json["classification"],
        model: json["model"],
        plateNumber: json["plate_number"],
        frontImage: json["front_image"],
        rearImage: json["rear_image"],
        drivingLicenseImage: json["driving_license_image"],
        registrationImage: json["registration_image"],
        deliveryAgentId: json["delivery_agent_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serial_number": serialNumber,
        "type": type,
        "classification": classification,
        "model": model,
        "plate_number": plateNumber,
        "front_image": frontImage,
        "rear_image": rearImage,
        "driving_license_image": drivingLicenseImage,
        "registration_image": registrationImage,
        "delivery_agent_id": deliveryAgentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
