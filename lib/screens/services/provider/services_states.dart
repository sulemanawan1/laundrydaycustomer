import 'package:laundryday/models/address_model.dart';
import 'package:laundryday/screens/home/provider/home_states.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/services/model/services_model.dart' as s;

class ServicesStates {
  List<AddressModel> address;
  int addressSelectedIndex;
    MyAddressModel? addressModel;

s.  ServiceModel? services;
  AppStates? appstates;
  ServicesStates({
    this.addressModel,
    required this.address,
    required this.addressSelectedIndex,
    this.appstates,
    this.services
  });

  ServicesStates copyWith({ s.ServiceModel ? services,
  AppStates? appstates,
    List<AddressModel>? address,
    int? addressSelectedIndex,
        MyAddressModel? addressModel

  }) {
    return ServicesStates(
      addressModel: addressModel??this.addressModel,
      appstates: appstates??this.appstates,
      services: services??this.services,
      address: address ?? this.address,
      addressSelectedIndex: addressSelectedIndex ?? this.addressSelectedIndex,
    );
  }
}
