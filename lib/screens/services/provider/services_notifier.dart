import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/helpers/google_helper.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/services/provider/services_states.dart';
import 'package:laundryday/screens/services/service/services_service.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;

final serviceProvider =
    StateNotifierProvider.autoDispose<ServicesNotifier, ServicesStates>(
        (ref) => ServicesNotifier());

class ServicesNotifier extends StateNotifier<ServicesStates> {
  servicemodel.ServiceModel servicesModel = servicemodel.ServiceModel();
  MyAddressModel? myAddressModel;

  ServicesNotifier()
      : super(ServicesStates(allServicesState: AllServicesInitialState())) {
    rqPermision();
    allServices();
  }

  rqPermision() async {
    bool pe = await GoogleServices().requestLocationPermission();

    if (pe == false) {
      await Geolocator.openLocationSettings();
    }
  }

  void allServices() async {
    try {
      state = state.copyWith(allServicesState: AllServicesLoadingState());

      var data = await ServicesService.allService();

      if (data is servicemodel.ServiceModel) {
        servicesModel = data;
        state = state.copyWith(
            allServicesState:
                AllServicesLoadedState(serviceModel: servicesModel));
      } else {
        state = state.copyWith(
            allServicesState:
                AllServicesErrorState(errorMessage: data.toString()));
      }
    } catch (e) {
      state = state.copyWith(
          allServicesState: AllServicesErrorState(errorMessage: e.toString()));
    }
  }

 
}
