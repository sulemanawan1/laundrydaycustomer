import 'package:laundryday/screens/order_review/presentaion/riverpod/order_review_states.dart';

class PaymentMethodStates {

  List<PaymentMethods> paymentMethods;
  PaymentMethods selectedPaymentMethod;
  PaymentMethodStates({
    required this.paymentMethods,
    required this.selectedPaymentMethod,
  });

  PaymentMethodStates copyWith({
    List<PaymentMethods>? paymentMethods,
    PaymentMethods? selectedPaymentMethod,
  }) {
    return PaymentMethodStates(
      paymentMethods: paymentMethods ?? this.paymentMethods,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }
}
