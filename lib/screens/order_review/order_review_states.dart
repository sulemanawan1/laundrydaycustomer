class OrderReviewStates {
  List<PaymentMethods> paymentMethods;
  int paymentSelectedIndex;
  double total;
  bool isPaid ;

  OrderReviewStates(
      {required this.paymentMethods,
      required this.paymentSelectedIndex,
      required this.total,
      
      this.isPaid=false});

  OrderReviewStates copyWith(
      {List<PaymentMethods>? paymentMethods,
      int? paymentSelectedIndex,
      double? total,
      bool? isPaid
      
      }) {
    return OrderReviewStates(
        paymentMethods: paymentMethods ?? this.paymentMethods,
        paymentSelectedIndex: paymentSelectedIndex ?? this.paymentSelectedIndex,
        total: total ?? this.total,
        isPaid: isPaid??this.isPaid);
  }
}

class PaymentMethods {
  final int id;
  final String icon;
  final String name;

  PaymentMethods({required this.id, required this.icon, required this.name});
}
