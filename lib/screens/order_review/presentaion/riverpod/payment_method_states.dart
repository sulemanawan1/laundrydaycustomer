import 'package:laundryday/screens/order_review/data/models/payment_method_model.dart';

class PaymentMethodStates {
  List<PaymentMethodModel> paymentMethods;
  PaymentMethodModel selectedPaymentMethod;
  PaymentMethodModel tempSelectedPaymentMethod;

  PaymentMethodStates({
    required this.paymentMethods,
    required this.selectedPaymentMethod,
   required this.tempSelectedPaymentMethod,
  });

  PaymentMethodStates copyWith({
    List<PaymentMethodModel>? paymentMethods,
    PaymentMethodModel? selectedPaymentMethod,
    PaymentMethodModel? tempSelectedPaymentMethod,

  }) {
    return PaymentMethodStates(
      tempSelectedPaymentMethod: tempSelectedPaymentMethod ?? this.tempSelectedPaymentMethod,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }
}
