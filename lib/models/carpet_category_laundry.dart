import 'package:laundryday/models/carpet.dart';
import 'package:laundryday/models/services_model.dart';

class CarpetCategoryLaundry {
  double? lat;
  String? name;
  double? lng;
  double? distance;
  double? rating;
  String? address;
  int? userRatingTotal;
  int? id;
  String? placeId;
  String? type;
  String? logo;
  ServicesModel? service;
  List<Carpet> carpets;

  CarpetCategoryLaundry(
      {this.lat,
      this.lng,
      this.rating,
      this.name,
      this.address,
      this.userRatingTotal,
      this.id,
      this.placeId,
      this.logo,
      this.distance,
      this.type,
      required this.service,
      required this.carpets});
}
