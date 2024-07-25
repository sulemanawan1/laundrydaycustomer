import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/models/order_invoice_model.dart';
import 'package:laundryday/models/order_status.dart';

class OrderModell {
  int orderId;
  String paymentMethod;
  double profit;
  double total;
  double itemTotalCharges;
  String status;
  String type;
  String? recording;
  String? pickupRecipt;
  List<ItemModel> items;
  List<OrderStatusModel> orderStatus;
  OrderInvoiceModel invoice;
  DateTime? startTime;
  DateTime? endTime;
  OrderModell({
    required this.orderId,
    required this.paymentMethod,
    required this.profit,
    required this.total,
    required this.itemTotalCharges,
    required this.status,
    required this.type,
    this.recording,
    this.pickupRecipt,
    required this.items,
    required this.orderStatus,
    required this.invoice,
    this.startTime,
    this.endTime,
  });

  OrderModell copyWith({
    int? orderId,
    String? paymentMethod,
    double? profit,
    double? total,
    double? itemTotalCharges,
    String? status,
    String? type,
    ValueGetter<String?>? recording,
    ValueGetter<String?>? pickupRecipt,
    List<ItemModel>? items,
    List<OrderStatusModel>? orderStatus,
    OrderInvoiceModel? invoice,
    ValueGetter<DateTime?>? startTime,
    ValueGetter<DateTime?>? endTime,
  }) {
    return OrderModell(
      orderId: orderId ?? this.orderId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      profit: profit ?? this.profit,
      total: total ?? this.total,
      itemTotalCharges: itemTotalCharges ?? this.itemTotalCharges,
      status: status ?? this.status,
      type: type ?? this.type,
      recording: recording != null ? recording() : this.recording,
      pickupRecipt: pickupRecipt != null ? pickupRecipt() : this.pickupRecipt,
      items: items ?? this.items,
      orderStatus: orderStatus ?? this.orderStatus,
      invoice: invoice ?? this.invoice,
     
      startTime: startTime != null ? startTime() : this.startTime,
      endTime: endTime != null ? endTime() : this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'paymentMethod': paymentMethod,
      'profit': profit,
      'total': total,
      'itemTotalCharges': itemTotalCharges,
      'status': status,
      'type': type,
      'recording': recording,
      'pickupRecipt': pickupRecipt,
      'items': items.map((x) => x.toMap()).toList(),
      'orderStatus': orderStatus.map((x) => x.toMap()).toList(),
      'invoice': invoice.toMap(),
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
    };
  }

  factory OrderModell.fromMap(Map<String, dynamic> map) {
    return OrderModell(
      orderId: map['orderId']?.toInt() ?? 0,
      paymentMethod: map['paymentMethod'] ?? '',
      profit: map['profit']?.toDouble() ?? 0.0,
      total: map['total']?.toDouble() ?? 0.0,
      itemTotalCharges: map['itemTotalCharges']?.toDouble() ?? 0.0,
      status: map['status'] ?? '',
      type: map['type'] ?? '',
      recording: map['recording'],
      pickupRecipt: map['pickupRecipt'],
      items:
          List<ItemModel>.from(map['items']?.map((x) => ItemModel.fromMap(x))),
      orderStatus: List<OrderStatusModel>.from(
          map['orderStatus']?.map((x) => OrderStatusModel.fromMap(x))),
      invoice: OrderInvoiceModel.fromMap(map['invoice']),
    
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : null,
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModell.fromJson(String source) =>
      OrderModell.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, paymentMethod: $paymentMethod, profit: $profit, total: $total, itemTotalCharges: $itemTotalCharges, status: $status, type: $type, recording: $recording, pickupRecipt: $pickupRecipt, items: $items, orderStatus: $orderStatus, invoice: $invoice, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModell &&
        other.orderId == orderId &&
        other.paymentMethod == paymentMethod &&
        other.profit == profit &&
        other.total == total &&
        other.itemTotalCharges == itemTotalCharges &&
        other.status == status &&
        other.type == type &&
        other.recording == recording &&
        other.pickupRecipt == pickupRecipt &&
        listEquals(other.items, items) &&
        listEquals(other.orderStatus, orderStatus) &&
        other.invoice == invoice &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        paymentMethod.hashCode ^
        profit.hashCode ^
        total.hashCode ^
        itemTotalCharges.hashCode ^
        status.hashCode ^
        type.hashCode ^
        recording.hashCode ^
        pickupRecipt.hashCode ^
        items.hashCode ^
        orderStatus.hashCode ^
        invoice.hashCode ^
        startTime.hashCode ^
        endTime.hashCode;
  }
}
