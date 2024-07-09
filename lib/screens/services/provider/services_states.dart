import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/services/model/services_model.dart'as servicemodel;

class ServicesStates {
  AllServicesState? allServicesState;

  ServicesStates({this.allServicesState});

  ServicesStates copyWith(
      {AllServicesState? allServicesState, MyAddressModel? addressModel}) {
    return ServicesStates(
      allServicesState: allServicesState ?? this.allServicesState,
    );
  }
}

abstract class AllServicesState {}

class AllServicesInitialState extends AllServicesState {}

class AllServicesLoadingState extends AllServicesState {}

class AllServicesLoadedState extends AllServicesState {
  servicemodel.ServiceModel serviceModel;

  AllServicesLoadedState({required this.serviceModel});
}

class AllServicesErrorState extends AllServicesState {
  final String errorMessage;
  AllServicesErrorState({required this.errorMessage});
}
