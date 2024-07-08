import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';

class MyAddressesStates {
  MyAddressModel? addressModel;
  MyAddressesStates({
     this.addressModel,
  });


  

  MyAddressesStates copyWith({
    MyAddressModel? addressModel,
  }) {
    return MyAddressesStates(
      addressModel: addressModel ?? this.addressModel,
    );
  }
}
