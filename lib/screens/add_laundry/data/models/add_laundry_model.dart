// To parse this JSON data, do
//
//     final addLaundryModel = addLaundryModelFromJson(jsonString);

import 'dart:convert';

AddLaundryModel addLaundryModelFromJson(String str) =>
    AddLaundryModel.fromJson(json.decode(str));

String addLaundryModelToJson(AddLaundryModel data) =>
    json.encode(data.toJson());

class AddLaundryModel {
  String? message;
  Data? data;

  AddLaundryModel({
    this.message,
    this.data,
  });

  AddLaundryModel copyWith({
    String? message,
    Data? data,
  }) =>
      AddLaundryModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory AddLaundryModel.fromJson(Map<String, dynamic> json) =>
      AddLaundryModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? name;
  String? arabicName;
  String? type;
  int? branches;
  String? taxNumber;
  String? commercialRegistrationNo;
  int? isCentralLaundry;
  String? commercialRegistrationImage;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? password;
  List<int>? serviceIds;
  List<BranchesList>? branchesList;
  int? userId;

  Data({
    this.name,
    this.arabicName,
    this.type,
    this.branches,
    this.taxNumber,
    this.commercialRegistrationNo,
    this.isCentralLaundry,
    this.commercialRegistrationImage,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.password,
    this.serviceIds,
    this.branchesList,
    this.userId,
  });

  Data copyWith({
    String? name,
    String? arabicName,
    String? type,
    int? branches,
    String? taxNumber,
    String? commercialRegistrationNo,
    int? isCentralLaundry,
    String? commercialRegistrationImage,
    String? firstName,
    String? lastName,
    String? mobileNumber,
    String? email,
    String? password,
    List<int>? serviceIds,
    List<BranchesList>? branchesList,
    int? userId,
  }) =>
      Data(
        name: name ?? this.name,
        arabicName: arabicName ?? this.arabicName,
        type: type ?? this.type,
        branches: branches ?? this.branches,
        taxNumber: taxNumber ?? this.taxNumber,
        commercialRegistrationNo:
            commercialRegistrationNo ?? this.commercialRegistrationNo,
        isCentralLaundry: isCentralLaundry ?? this.isCentralLaundry,
        commercialRegistrationImage:
            commercialRegistrationImage ?? this.commercialRegistrationImage,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        email: email ?? this.email,
        password: password ?? this.password,
        serviceIds: serviceIds ?? this.serviceIds,
        branchesList: branchesList ?? this.branchesList,
        userId: userId ?? this.userId,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        arabicName: json["arabic_name"],
        type: json["type"],
        branches: json["branches"],
        taxNumber: json["tax_number"],
        commercialRegistrationNo: json["commercial_registration_no"],
        isCentralLaundry: json["is_central_laundry"],
        commercialRegistrationImage: json["commercial_registration_image"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        password: json["password"],
        serviceIds: json["service_ids"] == null
            ? []
            : List<int>.from(json["service_ids"]!.map((x) => x)),
        branchesList: json["branches_list"] == null
            ? []
            : List<BranchesList>.from(
                json["branches_list"]!.map((x) => BranchesList.fromJson(x))),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "arabic_name": arabicName,
        "type": type,
        "branches": branches,
        "tax_number": taxNumber,
        "commercial_registration_no": commercialRegistrationNo,
        "is_central_laundry": isCentralLaundry,
        "commercial_registration_image": commercialRegistrationImage,
        "first_name": firstName,
        "last_name": lastName,
        "mobile_number": mobileNumber,
        "email": email,
        "password": password,
        "service_ids": serviceIds == null
            ? []
            : List<dynamic>.from(serviceIds!.map((x) => x)),
        "branches_list": branchesList == null
            ? []
            : List<dynamic>.from(branchesList!.map((x) => x.toJson())),
        "user_id": userId,
      };
}

class BranchesList {
  int? countryId;
  int? regionId;
  int? cityId;
  int? districtId;
  String? postalCode;
  String? area;
  String? googleMapAddress;
  double? lat;
  double? lng;
  String? address;

  BranchesList({
    this.countryId,
    this.regionId,
    this.cityId,
    this.districtId,
    this.postalCode,
    this.area,
    this.googleMapAddress,
    this.lat,
    this.lng,
    this.address,
  });

  BranchesList copyWith({
    int? countryId,
    int? regionId,
    int? cityId,
    int? districtId,
    String? postalCode,
    String? area,
    String? googleMapAddress,
    double? lat,
    double? lng,
    String? address,
  }) =>
      BranchesList(
        countryId: countryId ?? this.countryId,
        regionId: regionId ?? this.regionId,
        cityId: cityId ?? this.cityId,
        districtId: districtId ?? this.districtId,
        postalCode: postalCode ?? this.postalCode,
        area: area ?? this.area,
        googleMapAddress: googleMapAddress ?? this.googleMapAddress,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        address: address ?? this.address,
      );

  factory BranchesList.fromJson(Map<String, dynamic> json) => BranchesList(
        countryId: json["country_id"],
        regionId: json["region_id"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        postalCode: json["postal_code"],
        area: json["area"],
        googleMapAddress: json["google_map_address"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "country_id": countryId,
        "region_id": regionId,
        "city_id": cityId,
        "district_id": districtId,
        "postal_code": postalCode,
        "area": area,
        "google_map_address": googleMapAddress,
        "lat": lat,
        "lng": lng,
        "address": address,
      };
}
