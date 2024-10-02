import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/services/model/customer_order_model.dart';
import 'package:laundryday/screens/services/provider/services_states.dart';
import 'package:laundryday/screens/services/service/customer_order_repository.dart';
import 'package:laundryday/screens/services/service/services_service.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;

final customerOrdersApi = Provider((ref) {
  return CustomerOrderRepository();
});

final customerOrderProvider =
    FutureProvider.autoDispose<Either<String, CustomerOrderModel>>((ref) async {
  final userModel = ref.read(userProvider).userModel;
  return await ref
      .read(customerOrdersApi)
      .customerOrders(cutstomerId: userModel!.user!.id!);
});

final servicesApi = Provider((ref) {
  return ServicesService();
});

final servicesProvider =
    FutureProvider.autoDispose<Either<String, servicemodel.ServiceModel>>(
        (ref) async {
  return await ref.read(servicesApi).allService();
});

final serviceProvider = StateNotifierProvider<ServicesNotifier, ServicesStates>(
    (ref) => ServicesNotifier());

class ServicesNotifier extends StateNotifier<ServicesStates> {
  servicemodel.ServiceModel servicesModel = servicemodel.ServiceModel();
  MyAddressModel? myAddressModel;

  ServicesNotifier() : super(ServicesStates(order: [])) {
    GoogleServices().getLocation();
  }

  selectedService({required servicemodel.Datum selectedService}) {
    state = state.copyWith(selectedService: selectedService);
  }
}
