import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/order_review_states.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/payment_method_states.dart';

final PaymentMethodProvider = StateNotifierProvider.autoDispose<
    PaymentMethodNofifier,
    PaymentMethodStates>((ref) => PaymentMethodNofifier());

class PaymentMethodNofifier extends StateNotifier<PaymentMethodStates> {
  PaymentMethodNofifier()
      : super(PaymentMethodStates(
            paymentMethods: [
              
              PaymentMethods(
                  id: 1, icon: 'assets/icons/apple_pay.png', name: 'applepay'),
              PaymentMethods(
                  id: 2, icon: 'assets/icons/stc_pay.png', name: 'stc'),
              PaymentMethods(
                  id: 3, icon: 'assets/icons/credit_card.png', name: 'card'),
            ],
            selectedPaymentMethod: PaymentMethods(
                icon: 'assets/icons/credit_card.png', id: 3, name: 'card')));

  selectIndex({required PaymentMethods selectedPaymentMethod}) {
    debugPrint(selectedPaymentMethod.name);
    state = state.copyWith(selectedPaymentMethod: selectedPaymentMethod);
  }
}
