class PaymentOptionModel {
  String title;
  String paymentOption;
  PaymentOptionModel({
    required this.title,
    required this.paymentOption,
  });

  PaymentOptionModel copyWith({
    String? title,
    String? paymentOption,
  }) {
    return PaymentOptionModel(
      title: title ?? this.title,
      paymentOption: paymentOption ?? this.paymentOption,
    );
  }
}
