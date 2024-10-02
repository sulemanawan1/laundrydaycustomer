import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/models/address_model.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/service/my_adderesses_service.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:laundryday/screens/services/provider/addresses_state.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;
import 'package:location/location.dart';

final addressesApi = Provider((ref) {
  return AdderessesService();
});

final addressesProvider =
    FutureProvider.autoDispose<Either<String, myaddressmodel.MyAddressModel>>(
        (ref) async {
  final customerId = ref.read(userProvider).userModel!.user!.id!;
  return await ref.read(addressesApi).allAddresses(customerId: customerId);
});

final addressProvider =
    StateNotifierProvider.autoDispose<AddressesNotifier, AddressessStates>(
        (ref) => AddressesNotifier());

class AddressesNotifier extends StateNotifier<AddressessStates> {
  AddressesNotifier() : super(AddressessStates());

  Future getCurrentLocation() async {
    LocationData? position = await GoogleServices().getLocation();

    if (position != null) {
      state = state.copyWith(
          latLng: LatLng(position.latitude!, position.longitude!));
    }
  }

  Future getDistrict() async {
    LocationData? position = await GoogleServices().getLocation();

    if (position != null) {
      AddressModel? addressModel = await GoogleServices()
          .getAddress( position.latitude!, position.longitude!);
      state = state.copyWith(addressModel: addressModel);
    }
  }

  getAddress() async {
    Future.wait([getCurrentLocation(), getDistrict()]);
  }
}

final selectedAddressProvider =
    StateNotifierProvider<SelectedAddressNotifier, myaddressmodel.Address?>(
        (ref) => SelectedAddressNotifier());

class SelectedAddressNotifier extends StateNotifier<myaddressmodel.Address?> {
  SelectedAddressNotifier() : super(null);

  void selectAddress(myaddressmodel.Address address) {
    state = address;
  }
}
