import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/provider/my_addresses_states.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/service/my_adderesses_service.dart';
import 'package:laundryday/core/utils.dart';

import '../../../../services/provider/addresses_notifier.dart';

final myAddresesProvider =
    StateNotifierProvider.autoDispose<MyAddressesNotifier, MyAddressesStates>(
        (ref) {
  final customerId = ref.read(userProvider).userModel!.user!.id;

  return MyAddressesNotifier(customerId: customerId!);
});

class MyAddressesNotifier extends StateNotifier<MyAddressesStates> {
  final int customerId;
  MyAddressModel? myAddressModel;
  MyAddressesNotifier({required this.customerId})
      : super(MyAddressesStates()) {}

  Future<dynamic> deleteAddress(
      {required int addressId, required WidgetRef ref}) async {
    var data = await AdderessesService.deleteAddress(addressId: addressId);

    if (data == true) {
      ref.invalidate(addressesProvider);
    } else {
      Utils.showToast(msg: '$data');
      throw Exception(data);
    }
  }
}
