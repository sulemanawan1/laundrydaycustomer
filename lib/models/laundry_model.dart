import 'package:flutter/material.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/services_model.dart';

class LaundryModel {
  double? lat;
  String? name;
  String status;
  double? lng;
  double? distance;
  double? rating;
  String? address;
  int? userRatingTotal;
  int? id;
  String? placeId;
  String? type;
  String? logo;
  String? banner;
  ServicesModel? service;
  List<ServiceTypesModel> categories;
  List<TimeSlot> timeslot;

  LaundryModel(
      {this.lat,
      this.lng,
      this.rating,
      this.name,
      this.address,
      this.userRatingTotal,
      this.id,
      this.placeId,
      this.logo,
      this.banner,
      this.distance,
      this.type,
      required this.status,
      required this.service,
      required this.categories,
      required this.timeslot});
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
