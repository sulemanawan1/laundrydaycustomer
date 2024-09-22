import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/screens/services/model/customer_order_model.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;
import 'package:laundryday/screens/services/provider/services_notifier.dart';

class ServicesStates {
  List<Order> order;
  AllServicesState? allServicesState;
  String? district;
  LatLng? latLng;
  servicemodel.Datum? selectedService;

  ServicesStates(
      {
        
        required this.order,
        this.allServicesState,
      this.district,
      this.latLng,
      this.selectedService});

  ServicesStates copyWith(
      {List<Order>? order,

        servicemodel.Datum? selectedService,
      String? district,
      LatLng? latLng,
      AllServicesState? allServicesState}) {
    return ServicesStates(
      order:order ??this.order ,
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
