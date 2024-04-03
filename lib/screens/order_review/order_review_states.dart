class OrderReviewStates {
  List<PaymentMethods> paymentMethods;
  int paymentSelectedIndex;
  double total;
  bool isPaid;
  bool isRecording;
  OrderReviewStates({
    required this.paymentMethods,
    required this.paymentSelectedIndex,
    required this.total,
    required this.isPaid,
    required this.isRecording,
  });

  OrderReviewStates copyWith({
    List<PaymentMethods>? paymentMethods,
    int? paymentSelectedIndex,
    double? total,
    bool? isPaid,
    bool? isRecording,
  }) {
    return OrderReviewStates(
      paymentMethods: paymentMethods ?? this.paymentMethods,
      paymentSelectedIndex: paymentSelectedIndex ?? this.paymentSelectedIndex,
      total: total ?? this.total,
      isPaid: isPaid ?? this.isPaid,
      isRecording: isRecording ?? this.isRecording,
    );
  }
}

class PaymentMethods {
  final int id;
  final String icon;
  final String name;

  PaymentMethods({required this.id, required this.icon, required this.name});
}
