import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/helpers/google_helper.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/service/my_adderesses_service.dart';
import 'package:laundryday/screens/services/provider/addresses_state.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;

final addressProvider =
    StateNotifierProvider<AddressesNotifier, AddressessStates>(
        (ref) => AddressesNotifier());

class AddressesNotifier extends StateNotifier<AddressessStates> {
  AddressesNotifier()
      : super(AddressessStates(addressState: AddressesInitialState())) {}

 

  Future getCurrentLocation() async {
    Position position = await GoogleServices().currentLocation();

    state =
        state.copyWith(latLng: LatLng(position.latitude, position.longitude));
  }

  Future getDistrict() async {
    Position position = await GoogleServices().currentLocation();
    String? district = await GoogleServices()
        .getDistrict(position.latitude, position.longitude);

    state = state.copyWith(district: district);
  }

  getAddress() async {
    Future.wait([getCurrentLocation(), getDistrict()]);
  }

  Future<dynamic> allAddresses({
    required int customerId,
  }) async {
    print(customerId);
    try {
      state = state.copyWith(addressState: AddressesLoadingState());

      var data = await MyAdderessesService.allAddresses(customerId: customerId);

      if (data is MyAddressModel) {
        // print("------");
        // print(state.latLng!.latitude);
        // print("------");

        // data.addresses!.add(Address(
        //     addressName: 'my-current-address',
        //     addressDetail: 'my-current-address',
        //     googleMapAddress: state.district,
        //     district: state.district,
        //     lat: state.latLng!.latitude,
        //     lng: state.latLng!.longitude));

        state = state.copyWith(
            addressState: AddressesLoadedState(addressModel: data));
      } else {
        state = state.copyWith(
            addressState: AddressesErrorState(errorMessage: data.toString()));
      }
    } catch (e) {
      state = state.copyWith(
          addressState: AddressesErrorState(errorMessage: e.toString()));
    }
  }
}

final selectedAddressProvider =
    StateNotifierProvider<SelectedAddressNotifier, myaddressmodel.Address?>(
        (ref) => SelectedAddressNotifier());

class SelectedAddressNotifier extends StateNotifier<myaddressmodel.Address?> {
  SelectedAddressNotifier() : super(null);

  void onAddressTap(myaddressmodel.Address address) {
    log(address.id.toString());

    state = address;
  }
}
