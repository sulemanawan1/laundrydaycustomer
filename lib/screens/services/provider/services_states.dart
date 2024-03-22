
import 'package:laundryday/models/address_model.dart';

class ServicesStates {

  List<AddressModel> address;
  int addressSelectedIndex;
  ServicesStates({
    required this.address,
    required this.addressSelectedIndex,
  });




  ServicesStates copyWith({
    List<AddressModel>? address,
    int? addressSelectedIndex,
  }) {
    return ServicesStates(
      address: address ?? this.address,
      addressSelectedIndex: addressSelectedIndex ?? this.addressSelectedIndex,
    );
  }
}
