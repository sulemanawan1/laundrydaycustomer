import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/services_model.dart';

class QuantityNotifier extends StateNotifier<int> {
  QuantityNotifier() : super(0);

  addQuantitiy({required ServicesModel servicesModel}) {
    if (state >= 10) {
      state = 10;
    } else {
      state = state + 1;
    }
  }

  removeQuantitiy() {
    if (state <= 0) {
      state = 0;
    } else {
      state = state - 1;
    }
  }

  resetQuantitiy() {
    state = 0;
  }
}
