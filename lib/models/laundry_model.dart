import 'package:flutter/material.dart';
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
  String? placeId;
  String? type;
  String? logo;
  String? banner;
  ServicesModel? service;
  List<ServiceTypesModel> seviceTypes;
  List<TimeSlot>? timeslot;
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
    this.placeId,
    this.type,
    this.logo,
    this.banner,
    this.service,
    required this.seviceTypes,
     this.timeslot,
  });

 
}

class TimeSlot {
  TimeOfDay openTime;
  TimeOfDay closeTime;
  int weekNumber;

  TimeSlot(
      {required this.openTime,
      required this.closeTime,
      required this.weekNumber});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      openTime: TimeOfDay(
          hour: json['openTime']['hour'], minute: json['openTime']['minute']),
      closeTime: TimeOfDay(
          hour: json['closeTime']['hour'], minute: json['closeTime']['minute']),
      weekNumber: json['weekNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'openTime': {
        'hour': openTime.hour,
        'minute': openTime.minute,
      },
      'closeTime': {
        'hour': closeTime.hour,
        'minute': closeTime.minute,
      },
      'weekNumber': weekNumber,
    };
  }
}
