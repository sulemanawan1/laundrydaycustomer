import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/models/address_model.dart';



class AddressessStates {
  AddressModel? addressModel;
  LatLng? latLng;
  AddressessStates({
    this.addressModel,
    this.latLng,
  });

  AddressessStates copyWith({
    AddressModel? addressModel,
  LatLng? latLng,
  }) {
    return AddressessStates(
      addressModel: addressModel ?? this.addressModel,
      latLng: latLng ?? this.latLng,
    );
  }
}

