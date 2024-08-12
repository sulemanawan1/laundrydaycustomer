import 'package:laundryday/screens/add_laundry/data/models/coordinates.dart';

import 'package:laundryday/models/city_model.dart' as citymodel;
import 'package:laundryday/models/country_model.dart' as countrymodel;
import 'package:laundryday/models/district_model.dart' as districtmodel;
import 'package:laundryday/models/region_model.dart' as regionmodel;
class BranchModel {
  countrymodel.Datum? country;
  Coordinates? coordinates;
  regionmodel.Datum? region;
  citymodel.Datum? city;
  districtmodel.Datum? district;
  String? area;
  String? postalCode;
  String? googleMapAddress;
  String? licenceImage;

  BranchModel({
    this.coordinates,
    this.country,
    this.region,
    this.city,
    this.district,
    this.area,
    this.postalCode,
    this.googleMapAddress,
    this.licenceImage,
  });

  BranchModel copyWith(
      {Coordinates? coordinates,
      countrymodel.Datum? country,
      regionmodel.Datum? region,
      citymodel.Datum? city,
      districtmodel.Datum? district,
      String? area,
      String? postalCode,
      String? googleMapAddress,
      double? lat,
      double? lng,
      String? licenceImage}) {
    return BranchModel(
      licenceImage: licenceImage ?? this.licenceImage,
      country: country ?? this.country,
      region: region ?? this.region,
      city: city ?? this.city,
      district: district ?? this.district,
      area: area ?? this.area,
      postalCode: postalCode ?? this.postalCode,
      googleMapAddress: googleMapAddress ?? this.googleMapAddress,
    );
  }
}
