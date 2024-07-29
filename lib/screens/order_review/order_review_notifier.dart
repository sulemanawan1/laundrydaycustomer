import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/order_review/order_review_states.dart';

class OrderReviewNotifier extends StateNotifier<OrderReviewStates> {
  OrderReviewNotifier()
      : super(OrderReviewStates(
            items: [],
            isRecording: false,
            isPaid: false,
            total: 0.0,
            paymentSelectedIndex: -1,
            paymentMethods: [
              PaymentMethods(
                  id: 1, icon: 'assets/icons/apple_pay.png', name: 'apple pay'),
              PaymentMethods(
                  id: 2, icon: 'assets/icons/stc_pay.png', name: 'stc pay'),
              PaymentMethods(
                  id: 3,
                  icon: 'assets/icons/credit_card.png',
                  name: 'card payment'),
            ]));

  selectIndex({required int index}) {
    state = state.copyWith(paymentSelectedIndex: index);
  }

  isPaymentStatus({required bool isPaid}) {
    state = state.copyWith(isPaid: isPaid);
  }

  recordingStatus({required bool input}) {
    state = state.copyWith(isRecording: input);
  }

  Future getAllItems() async {
    List<ItemVariation> items =
        await DatabaseHelper.instance.getAllItemVariations();

    print(items.length);
    state = state.copyWith(items: items);
  }
}
