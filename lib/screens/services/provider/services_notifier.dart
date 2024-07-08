import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/address_model.dart';
import 'package:laundryday/screens/home/provider/home_states.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/service/my_adderesses_service.dart';
import 'package:laundryday/screens/services/provider/services_states.dart';
import 'package:laundryday/screens/services/service/services_service.dart';
import 'package:laundryday/screens/services/model/services_model.dart' as s;
import 'package:laundryday/utils/utils.dart';

final serviceProvider =
    StateNotifierProvider.autoDispose<ServicesNotifier, ServicesStates>(
        (ref) => ServicesNotifier());

class ServicesNotifier extends StateNotifier<ServicesStates> {
  s.ServiceModel servicesModel = s.ServiceModel();
  MyAddressModel? myAddressModel;

  ServicesNotifier()
      : super(ServicesStates(addressSelectedIndex: -1, address: [
          AddressModel(name: 'my current location', address: 'Al Hazm Riyadh '),
          AddressModel(name: 'Office', address: 'Al Mahamid Riyadh '),
        ])) {
    allServices();
  }

  

  void allServices() async {
    state = state.copyWith(appstates: AppStates.initial);
    var data = await ServicesService.allService();

    if (data is s.ServiceModel) {
      servicesModel = data;
      state = state.copyWith(services: data, appstates: AppStates.loaded);
    } else {
      print("object");
      state = state.copyWith(appstates: AppStates.error);
    }



  }
}
