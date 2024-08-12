import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';

class OrderReviewStates {
  double total;
  bool isPaid;
  bool isRecording;
  List<ItemVariation> items;
  OrderReviewStates({
    required this.items,
    required this.total,
    required this.isPaid,
    required this.isRecording,
  });

  OrderReviewStates copyWith({
    PaymentMethods? selectedPaymentMethod,
    List<ItemVariation>? items,
    double? total,
    bool? isPaid,
    bool? isRecording,
  }) {
    return OrderReviewStates(
      items: items ?? this.items,
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
