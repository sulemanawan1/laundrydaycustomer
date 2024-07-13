import 'package:image_picker/image_picker.dart';

import 'package:laundryday/models/city_model.dart' as citymodel;
import 'package:laundryday/models/country_model.dart' as countrymodel;
import 'package:laundryday/models/district_model.dart' as districtmodel;
import 'package:laundryday/models/region_model.dart' as regionmodel;
import 'package:laundryday/screens/more/help/agent_registration/model/delivery_agent_registartion_model.dart';

enum IDType { residentId, nationalId }

// National Id,Residen Id
class DeliveryAgentStates {
  DeliveryAgentButtonState deliveryAgentButtonState;
  List IdentityTypes;
  XFile? image;
  String? dateOfBirth;
  XFile? identityImage;
  XFile? frontImage;
  XFile? rearImage;
  XFile? drivingLicenseImage;
  XFile? registrationImage;
  IDType? idType;
  countrymodel.CountryModel? countryModel;
  countrymodel.Datum? selectedCountry;
  regionmodel.RegionModel? regionModel;
  regionmodel.Datum? selectedRegion;
  citymodel.CityModel? cityModel;
  citymodel.Datum? selectedCity;
  districtmodel.DistrictModel? districtModel;
  districtmodel.Datum? selectedDistrict;
  DeliveryAgentStates({
    required this.deliveryAgentButtonState,
    this.image,
    required this.IdentityTypes,
    this.dateOfBirth,
    this.identityImage,
    this.frontImage,
    this.rearImage,
    this.drivingLicenseImage,
    this.registrationImage,
    this.idType,
    this.countryModel,
    this.selectedCountry,
    this.regionModel,
    this.selectedRegion,
    this.cityModel,
    this.selectedCity,
    this.districtModel,
    this.selectedDistrict,
  });

  DeliveryAgentStates copyWith(
      {List? IdentityTypes,
      XFile? image,
      String? dateOfBirth,
      XFile? identityImage,
      XFile? frontImage,
      XFile? rearImage,
      XFile? drivingLicenseImage,
      XFile? registrationImage,
      IDType? idType,
      countrymodel.CountryModel? countryModel,
      countrymodel.Datum? selectedCountry,
      regionmodel.RegionModel? regionModel,
      regionmodel.Datum? selectedRegion,
      citymodel.CityModel? cityModel,
      citymodel.Datum? selectedCity,
      districtmodel.DistrictModel? districtModel,
      districtmodel.Datum? selectedDistrict,
      DeliveryAgentButtonState? deliveryAgentButtonStates}) {
    return DeliveryAgentStates(
      deliveryAgentButtonState:
          deliveryAgentButtonStates ?? this.deliveryAgentButtonState,
      IdentityTypes: IdentityTypes ?? this.IdentityTypes,
      image: image ?? this.image,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      identityImage: identityImage ?? this.identityImage,
      frontImage: frontImage ?? this.frontImage,
      rearImage: rearImage ?? this.rearImage,
      drivingLicenseImage: drivingLicenseImage ?? this.drivingLicenseImage,
      registrationImage: registrationImage ?? this.registrationImage,
      idType: idType ?? this.idType,
      countryModel: countryModel ?? this.countryModel,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      regionModel: regionModel ?? this.regionModel,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      cityModel: cityModel ?? this.cityModel,
      selectedCity: selectedCity ?? this.selectedCity,
      districtModel: districtModel ?? this.districtModel,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
    );
  }
}

abstract class DeliveryAgentButtonState {}

class DeliveryAgentButtonInitialState extends DeliveryAgentButtonState {}

class DeliveryAgentButtonLoadingState extends DeliveryAgentButtonState {}

class DeliveryAgentButtonLoadedState extends DeliveryAgentButtonState {
  DeliveryAgentRegistrationModel deliveryAgentRegistrationModel;

  DeliveryAgentButtonLoadedState(
      {required this.deliveryAgentRegistrationModel});
}

class DeliveryAgentButtonErrorState extends DeliveryAgentButtonState {
  final String errorMessage;
  DeliveryAgentButtonErrorState({required this.errorMessage});
}
