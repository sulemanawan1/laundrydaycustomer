import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/screens/add_laundry/models/coordinates.dart';
import 'package:laundryday/screens/add_laundry/models/selected_branch_model.dart';

import 'package:laundryday/models/city_model.dart' as citymodel;
import 'package:laundryday/models/country_model.dart' as countrymodel;
import 'package:laundryday/models/district_model.dart' as districtmodel;
import 'package:laundryday/models/region_model.dart' as regionmodel;
import 'package:laundryday/screens/services/model/services_model.dart';

class AddLaundryStates {
  
  List<BranchModel> selectedBranchModel;
  countrymodel.CountryModel? countryModel;
  countrymodel.Datum? selectedCountry;
  regionmodel.RegionModel? regionModel;
  regionmodel.Datum? selectedRegion;
  citymodel.CityModel? cityModel;
  citymodel.Datum? selectedCity;
  districtmodel.DistrictModel? districtModel;
  districtmodel.Datum? selectedDistrict;
  ServiceModel? servicesModel;
  List<int> serviceIds;
  int currentStep;
  XFile? image;
  String? base64Image;
  XFile? licenceImage;
  String? licenseImagebase64Image;
  String? categoryType;
  List<dynamic> placeList = [];
  String? googleMapAdress;
  Set<Marker> markers;
  Coordinates? coordinates;

  AddLaundryStates({
    required this.selectedBranchModel,
    this.base64Image,
    required this.serviceIds,
    this.servicesModel,
    this.cityModel,
    this.districtModel,
    this.selectedCity,
    this.selectedDistrict,
    this.regionModel,
    this.selectedRegion,
    this.countryModel,
    this.selectedCountry,
    required this.currentStep,
    this.coordinates,
    this.googleMapAdress,
    this.image,
    this.categoryType,
    required this.markers,
    required this.placeList,
    this.licenceImage,
    this.licenseImagebase64Image
  });

  AddLaundryStates copyWith(
      {List<BranchModel>? selectedBranchModel,
      ServiceModel? servicesModel,
      countrymodel.Datum? selectedCountry,
      countrymodel.CountryModel? countryModel,
      regionmodel.RegionModel? regionModel,
      regionmodel.Datum? selectedRegion,
      citymodel.CityModel? cityModel,
      citymodel.Datum? selectedCity,
      districtmodel.DistrictModel? districtModel,
      districtmodel.Datum? selectedDistrict,
      List<int>? serviceIds,
      String? base64Image,
      int? currentStep,
      XFile? image,
      String? googleMapAdress,
      String? categoryType,
      List<dynamic>? placeList,
      String? address,
      double? selectedLat,
      double? selectedLng,
      Coordinates? coordinates,
      Set<Marker>? markers,
        XFile? licenceImage,
  String? licenseImagebase64Image
      }) {
    return AddLaundryStates(
        selectedBranchModel: selectedBranchModel ?? this.selectedBranchModel,
        cityModel: cityModel ?? this.cityModel,
        selectedCity: selectedCity ?? this.selectedCity,
        districtModel: districtModel ?? this.districtModel,
        selectedDistrict: selectedDistrict ?? this.selectedDistrict,
        base64Image: base64Image ?? this.base64Image,
        servicesModel: servicesModel ?? this.servicesModel,
        countryModel: countryModel ?? this.countryModel,
        selectedCountry: selectedCountry ?? this.selectedCountry,
        regionModel: regionModel ?? this.regionModel,
        selectedRegion: selectedRegion ?? this.selectedRegion,
        serviceIds: serviceIds ?? this.serviceIds,
        markers: markers ?? this.markers,
        googleMapAdress: googleMapAdress ?? this.googleMapAdress,
        currentStep: currentStep ?? this.currentStep,
        image: image ?? this.image,
        categoryType: categoryType ?? this.categoryType,
        placeList: placeList ?? this.placeList,
        coordinates: coordinates ?? this.coordinates,
        licenceImage: licenceImage??this.licenceImage,
        licenseImagebase64Image: licenseImagebase64Image??this.licenseImagebase64Image
        
        );
        
  }
}
