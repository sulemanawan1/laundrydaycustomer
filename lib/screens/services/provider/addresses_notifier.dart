import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/service/my_adderesses_service.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;

final addressesApi = Provider((ref) {
  return AdderessesService();
});

final addressesProvider =
    FutureProvider.autoDispose<Either<String, myaddressmodel.MyAddressModel>>(
        (ref) async {
  final customerId = ref.read(userProvider).userModel!.user!.id!;

  return await ref.read(addressesApi).allAddresses(customerId: customerId);
});

final selectedAddressProvider =
    StateNotifierProvider<SelectedAddressNotifier, myaddressmodel.Address?>(
        (ref) => SelectedAddressNotifier());

class SelectedAddressNotifier extends StateNotifier<myaddressmodel.Address?> {
  SelectedAddressNotifier() : super(null);

  void selectAddress(myaddressmodel.Address address) {
    state = address;
  }
}
