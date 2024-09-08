import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/helpers/google_helper.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/services/model/customer_order_model.dart';
import 'package:laundryday/screens/services/provider/services_states.dart';
import 'package:laundryday/screens/services/service/customer_order_repository.dart';
import 'package:laundryday/screens/services/service/services_service.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;

final serviceProvider =
    StateNotifierProvider.autoDispose<ServicesNotifier, ServicesStates>(
        (ref) => ServicesNotifier());

class ServicesNotifier extends StateNotifier<ServicesStates> {
  CustomerOrderRepository _customerOrderRepository = CustomerOrderRepository();
  servicemodel.ServiceModel servicesModel = servicemodel.ServiceModel();
  MyAddressModel? myAddressModel;

  ServicesNotifier()
      : super(ServicesStates(
            order: [],
            customerOrderStates: CustomerOrderInititalState(),
            allServicesState: AllServicesInitialState())) {
    GoogleServices().getLocation();
    allServices();
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
        customerOrders(customerId: 5);
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

  selectedService({required servicemodel.Datum selectedService}) {
    state = state.copyWith(selectedService: selectedService);
  }

  customerOrders({
    required int customerId,
  }) async {
    try {
      state = state.copyWith(customerOrderStates: CustomerOrderInititalState());

      Either<String, CustomerOrderModel> apiData =
          await _customerOrderRepository.customerOrders(
              cutstomerId: customerId);

      apiData.fold((l) {
        state = state.copyWith(
            customerOrderStates:
                CustomerOrderErrorState(errorMessage: 'An Error Occured'));
        debugPrint(l);
      }, (r) {
        debugPrint(r.message);

        state = state.copyWith(
            customerOrderStates: CustomerOrderLoadedState(), order: r.order);
      });
    } catch (e) {
      debugPrint(e.toString());

      state = state.copyWith(
          customerOrderStates:
              CustomerOrderErrorState(errorMessage: 'An Error Occured'));
    }
  }
}

abstract class CustomerOrderStates {}

class CustomerOrderInititalState extends CustomerOrderStates {}

class CustomerOrderLoadingState extends CustomerOrderStates {}

class CustomerOrderLoadedState extends CustomerOrderStates {}

class CustomerOrderErrorState extends CustomerOrderStates {
  final String errorMessage;
  CustomerOrderErrorState({
    required this.errorMessage,
  });
}
