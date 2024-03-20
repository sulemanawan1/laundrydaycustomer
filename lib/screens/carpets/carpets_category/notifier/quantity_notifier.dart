import 'package:flutter_riverpod/flutter_riverpod.dart';

final quantityProvider =
    StateNotifierProvider.autoDispose<QuantityNotifier, int>(
        (ref) => QuantityNotifier());

class QuantityNotifier extends StateNotifier<int> {
  QuantityNotifier() : super(0);

  resetQuantity() {
    state = 0;
  }
}
