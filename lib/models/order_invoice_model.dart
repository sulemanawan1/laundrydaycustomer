import 'dart:convert';

class OrderInvoiceModel {
  int id;
  int orderId;
  double amount;
  String image;
  OrderInvoiceModel({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.image,
  });

  OrderInvoiceModel copyWith({
    int? id,
    int? orderId,
    double? amount,
    String? image,
  }) {
    return OrderInvoiceModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      amount: amount ?? this.amount,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'amount': amount,
      'image': image,
    };
  }

  factory OrderInvoiceModel.fromMap(Map<String, dynamic> map) {
    return OrderInvoiceModel(
      id: map['id']?.toInt() ?? 0,
      orderId: map['orderId']?.toInt() ?? 0,
      amount: map['amount']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderInvoiceModel.fromJson(String source) =>
      OrderInvoiceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderInvoiceModel(id: $id, orderId: $orderId, amount: $amount, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderInvoiceModel &&
        other.id == id &&
        other.orderId == orderId &&
        other.amount == amount &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ orderId.hashCode ^ amount.hashCode ^ image.hashCode;
  }
}
