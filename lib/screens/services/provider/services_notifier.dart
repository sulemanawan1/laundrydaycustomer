import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/address_model.dart';
import 'package:laundryday/screens/services/provider/services_states.dart';

class ServicesNotifier extends StateNotifier<ServicesStates> {
  ServicesNotifier()
      : super(ServicesStates(addressSelectedIndex: -1, address: [

        AddressModel(name: 'my current location',address: 'Al Hazm Riyadh '),
          AddressModel(name: 'Office', address: 'Al Mahamid Riyadh '),
         
        ]));

  selectIndex({required int index}) {
    state = state.copyWith(addressSelectedIndex: index);
  }
}
