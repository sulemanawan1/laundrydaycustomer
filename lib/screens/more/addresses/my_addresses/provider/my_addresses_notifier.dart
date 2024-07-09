import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/provider/my_addresses_states.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/service/my_adderesses_service.dart';
import 'package:laundryday/utils/utils.dart';

final myAddresesProvider =
    StateNotifierProvider.autoDispose<MyAddressesNotifier, MyAddressesStates>(
        (ref) {
  final customerId = ref.read(userProvider).userModel!.user!.id;

  return MyAddressesNotifier(customerId: customerId!);
});

class MyAddressesNotifier extends StateNotifier<MyAddressesStates> {
  final int customerId;
  MyAddressModel? myAddressModel;
  MyAddressesNotifier({required this.customerId}) : super(MyAddressesStates()) {
    allAddresses(customerId: customerId);
  }
  Future<dynamic> allAddresses({
    required int customerId,
  }) async {
    var data = await MyAdderessesService.allAddresses(customerId: customerId);

    if (data is MyAddressModel) {
      log("Success");
      state = state.copyWith(addressModel: data);
    } else {
      Utils.showToast(msg: '$data');
      throw Exception(data);
    }
  }

  Future<dynamic> deleteAddress(
      {required int addressId, required WidgetRef ref}) async {
    var data = await MyAdderessesService.deleteAddress(addressId: addressId);

    if (data == true) {
      ref.invalidate(myAddresesProvider);
    } else {
      Utils.showToast(msg: '$data');
      throw Exception(data);
    }
  }
}
