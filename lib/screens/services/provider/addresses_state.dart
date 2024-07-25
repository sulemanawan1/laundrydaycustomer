import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'  as myaddressmodel;

abstract class AddressesState {}

class AddressesInitialState extends AddressesState {}

class AddressesLoadingState extends AddressesState {}

class AddressesLoadedState extends AddressesState {
  myaddressmodel.MyAddressModel addressModel;

  AddressesLoadedState({required this.addressModel});
}

class AddressSelectedState extends AddressesState {
  final myaddressmodel.Address? selectedAddress;

  AddressSelectedState({ this.selectedAddress});
}

class AddressesErrorState extends AddressesState {
  final String errorMessage;
  AddressesErrorState({required this.errorMessage});
}
