import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';

class OrderReviewStates {
  List<PaymentMethods> paymentMethods;
  int paymentSelectedIndex;
  double total;
  bool isPaid;
  bool isRecording;
  List<ItemVariation> items;
  OrderReviewStates({
    required this.items,
    required this.paymentMethods,
    required this.paymentSelectedIndex,
    required this.total,
    required this.isPaid,
    required this.isRecording,
  });

  OrderReviewStates copyWith({
      List<ItemVariation>? items,

    List<PaymentMethods>? paymentMethods,
    int? paymentSelectedIndex,
    double? total,
    bool? isPaid,
    bool? isRecording,
  }) {
    return OrderReviewStates(
      items: items??this.items,
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
