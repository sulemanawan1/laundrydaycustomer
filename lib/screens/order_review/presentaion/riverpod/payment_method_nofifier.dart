import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/order_review/data/models/payment_method_model.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/payment_method_states.dart';

final PaymentMethodProvider = StateNotifierProvider.autoDispose<
    PaymentMethodNofifier,
    PaymentMethodStates>((ref) => PaymentMethodNofifier());

class PaymentMethodNofifier extends StateNotifier<PaymentMethodStates> {
  PaymentMethodNofifier()
      : super(PaymentMethodStates(
            paymentMethods: [
              PaymentMethodModel(
                  id: 1, icon: 'assets/icons/apple_pay.png', name: 'applepay'),
              PaymentMethodModel(
                  id: 2, icon: 'assets/icons/stc_pay.png', name: 'stc'),
              PaymentMethodModel(
                  id: 3, icon: 'assets/icons/credit_card.png', name: 'card'),
            ],
            selectedPaymentMethod: PaymentMethodModel(
                icon: 'assets/icons/credit_card.png', id: 3, name: 'card'),
            tempSelectedPaymentMethod: PaymentMethodModel(
                icon: 'assets/icons/credit_card.png', id: 3, name: 'card')));

  selectIndex({required PaymentMethodModel selectedPaymentMethod}) {
    state = state.copyWith(selectedPaymentMethod: selectedPaymentMethod);
  }

  selectTempIndex({required PaymentMethodModel selectedPaymentMethod}) {
    state = state.copyWith(tempSelectedPaymentMethod: selectedPaymentMethod);
  }


  
}
