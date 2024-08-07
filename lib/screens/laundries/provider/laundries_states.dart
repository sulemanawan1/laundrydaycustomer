import 'package:laundryday/screens/laundries/model/delivery_pickup_laundry_model.dart';
import 'package:laundryday/screens/laundries/model/laundry_by_area.model.dart';
import 'package:laundryday/screens/laundries/model/services_timings_model.dart'
    as servicetimingmodel;

class LaundriesStates {
  LaundryByAreaState laundryByAreaState;
  servicetimingmodel.Datum? serviceTiming;
  DeliveryPickupLaundryState deliveryPickupLaundryState;
  LaundriesStates({
    this.serviceTiming,
    required this.deliveryPickupLaundryState,
    required this.laundryByAreaState,
  });

  LaundriesStates copyWith(
      {servicetimingmodel.Datum? serviceTiming,
      LaundryByAreaState? laundryByAreaState,
      DeliveryPickupLaundryState? deliveryPickupLaundryState}) {
    return LaundriesStates(
      serviceTiming: serviceTiming??this.serviceTiming,
      deliveryPickupLaundryState:
          deliveryPickupLaundryState ?? this.deliveryPickupLaundryState,
      laundryByAreaState: laundryByAreaState ?? this.laundryByAreaState,
    );


    
  }


  
}

abstract class LaundryByAreaState {}

class LaundryByAreaIntitialState extends LaundryByAreaState {}

class LaundryByAreaLoadingState extends LaundryByAreaState {}

class LaundryByAreaLoadedState extends LaundryByAreaState {
  LaundryByAreaModel laundryByAreaModel;
  LaundryByAreaLoadedState({required this.laundryByAreaModel});
}

class LaundryByAreaErrorState extends LaundryByAreaState {
  String errorMessage;
  LaundryByAreaErrorState({required this.errorMessage});
}

abstract class DeliveryPickupLaundryState {}

class DeliveryPickupLaundryIntitialState extends DeliveryPickupLaundryState {}

class DeliveryPickupLaundryLoadingState extends DeliveryPickupLaundryState {}

class DeliveryPickupLaundryLoadedState extends DeliveryPickupLaundryState {
  List<DeliveryPickupLaundryModel> deliveryPickupLaundryModel;
  DeliveryPickupLaundryLoadedState({required this.deliveryPickupLaundryModel});
}

class DeliveryPickupLaundryErrorState extends DeliveryPickupLaundryState {
  String errorMessage;
  DeliveryPickupLaundryErrorState({required this.errorMessage});
}
