import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/service/my_adderesses_service.dart';
import 'package:laundryday/screens/services/provider/addresses_state.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;
import 'package:laundryday/screens/services/provider/services_notifier.dart';

final serviceAddressesProvider =
    StateNotifierProvider<AddressesNotifier, AddressesState>((ref) {
  return AddressesNotifier();
});

class AddressesNotifier extends StateNotifier<AddressesState> {
  AddressesNotifier() : super(AddressesInitialState()) {}

  Future<dynamic> allAddresses({
    required int customerId,
    required WidgetRef ref,
  }) async {
    try {
      var servicestates = ref.read(serviceProvider);
      state = AddressesLoadingState();

      var data = await MyAdderessesService.allAddresses(customerId: customerId);

      if (data is MyAddressModel) {
        log(servicestates.latLng!.latitude.toString());
        log(servicestates.latLng!.longitude.toString());
        data.addresses?.add(Address(
            addressName: 'my-current-address',
            addressDetail: 'my-current-address',
            googleMapAddress: servicestates.district,
            district: servicestates.district,
            lat: servicestates.latLng?.latitude,
            lng: servicestates.latLng?.longitude));
        state = AddressesLoadedState(addressModel: data);
      } else {
        state = AddressesErrorState(errorMessage: data.toString());
      }
    } catch (e) {
      state = AddressesErrorState(errorMessage: e.toString());
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
