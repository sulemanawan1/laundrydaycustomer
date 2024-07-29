import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
  as myaddressmodel;

class AddressessStates {
  AddressState addressState;
  String? district;
  LatLng? latLng;
  AddressessStates({
    required this.addressState,
    this.district,
    this.latLng,
  });

  AddressessStates copyWith({
    AddressState? addressState,
    String? district,
  LatLng? latLng,
  }) {
    return AddressessStates(
      addressState: addressState ?? this.addressState,
      district:district?? this.district,
      latLng: latLng ?? this.latLng,
    );
  }
}

abstract class AddressState {}

class AddressesInitialState extends AddressState {}

class AddressesLoadingState extends AddressState {}

class AddressesLoadedState extends AddressState {
  myaddressmodel.MyAddressModel addressModel;

  AddressesLoadedState({required this.addressModel});
}

class AddressSelectedState extends AddressState {
  final myaddressmodel.Address? selectedAddress;

  AddressSelectedState({this.selectedAddress});
}

class AddressesErrorState extends AddressState {
  final String errorMessage;
  AddressesErrorState({required this.errorMessage});
}
