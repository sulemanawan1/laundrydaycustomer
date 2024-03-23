import 'package:image_picker/image_picker.dart';

import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/models/user_model.dart';

class BusinessPartnerModel {
  List<LaundryBusinessModel> laundries;
  UserModel user;
  BusinessPartnerModel({
    required this.laundries,
    required this.user,
  });
}

class LaundryBusinessModel {
  String? name;
  int? branches;
  String? taxNumber;
  String? commercialRegNo;
  XFile? commercialRegImage;
  String? secondaryName;
  String? region;
  String? city;
  double? lat;
  double? lng;
  double? distance;
  String? address;
  String? googleMapAddress;
  String? id;
  String? type;
  String? logo;
  String? banner;
  List<ServicesModel>? service;
  ServiceTypesModel? seviceTypes;
  LaundryBusinessModel({
    this.name,
    this.branches,
    this.taxNumber,
    this.commercialRegNo,
    this.commercialRegImage,
    this.secondaryName,
    this.region,
    this.city,
    this.lat,
    this.lng,
    this.distance,
    this.address,
    this.googleMapAddress,
    this.id,
    this.type,
    this.logo,
    this.banner,
    this.service,
    this.seviceTypes,
  });
}
