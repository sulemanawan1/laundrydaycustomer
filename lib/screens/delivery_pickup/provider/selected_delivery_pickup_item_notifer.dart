import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/blankets_model.dart';

class SelectedDeliveryPickupItemNotifer
    extends StateNotifier<List<LaundryItemModel>> {
  SelectedDeliveryPickupItemNotifer() : super([]);

  addItem({required LaundryItemModel item}) {
    state.add(item);

    state = [...state];
  }

  deleteItem({required id}) {
    state.removeWhere((element) => element.id == id);

    state = [...state];
  }
}
