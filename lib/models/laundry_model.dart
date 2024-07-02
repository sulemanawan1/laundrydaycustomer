import 'package:image_picker/image_picker.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/services_model.dart';

class LaundryModel {
  String? name;
  int? branches;
  int? taxNumber;
  int? commercialRegNo;
  XFile? commercialRegImage;
  String? secondaryName;
  String? region;
  String? city;
  String? status;
  double? lat;
  double? lng;
  double? distance;
  double? rating;
  String? address;
  String? googleMapAddress;
  int? userRatingTotal;
  int? id;
  String? type;
  String? logo;
  String? banner;
  ServicesModel? service;
  List<ServiceTypesModel> seviceTypes;
  LaundryModel({
    this.name,
    this.branches,
    this.taxNumber,
    this.commercialRegNo,
    this.commercialRegImage,
    this.secondaryName,
    this.region,
    this.city,
     this.status,
    this.lat,
    this.lng,
    this.distance,
    this.rating,
    this.address,
    this.userRatingTotal,
    this.id,
    this.type,
    this.logo,
    this.banner,
    this.service,
    required this.seviceTypes,
  });

 
}

