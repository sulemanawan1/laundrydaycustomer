import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;

class ServicesStates {
  AllServicesState? allServicesState;
  String? district;
  LatLng? latLng;
  servicemodel.Datum? selectedService;

  ServicesStates(
      {this.allServicesState,
      this.district,
      this.latLng,
      this.selectedService});

  ServicesStates copyWith(
      {servicemodel.Datum? selectedService,
      String? district,
      LatLng? latLng,
      AllServicesState? allServicesState}) {
    return ServicesStates(
      selectedService: selectedService??this.selectedService,
      district: district ?? this.district,
      latLng: latLng ?? this.latLng,
      allServicesState: allServicesState ?? this.allServicesState,
    );
  }
}

abstract class AllServicesState {}

class AllServicesInitialState extends AllServicesState {}

class AllServicesLoadingState extends AllServicesState {}

class AllServicesLoadedState extends AllServicesState {
  servicemodel.ServiceModel serviceModel;

  AllServicesLoadedState({required this.serviceModel});
}

class AllServicesErrorState extends AllServicesState {
  final String errorMessage;
  AllServicesErrorState({required this.errorMessage});
}
