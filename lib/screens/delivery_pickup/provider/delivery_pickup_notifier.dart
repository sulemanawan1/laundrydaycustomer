import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/blankets_model.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';

class DeliveryPickupNotifier extends StateNotifier<List<LaundryItemModel>> {
  final Ref ref;
  final int? serviceId;
  DeliveryPickupNotifier({required this.ref, required this.serviceId})
      : super([]) {
    fetchAllItems(ref: ref, serviceId: serviceId!);
  }

  fetchAllItems({required Ref ref, required int serviceId}) {
    ref
        .read(deliveryPickupRepositoryProvider)
        .getAllItems(serviceId: serviceId)
        .then((value) {
      state = value;
    });
  }
}
