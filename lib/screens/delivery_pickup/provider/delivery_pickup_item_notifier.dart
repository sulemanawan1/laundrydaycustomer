import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/blankets_model.dart';

class DeliveryPickupItemNotifier extends StateNotifier<LaundryItemModel?> {
  DeliveryPickupItemNotifier() : super(null);

  selectBlanketItem({required LaundryItemModel orderItem}) {
    state = orderItem;
  }

  resetBlanketItem() {
    state = null;
  }
}
