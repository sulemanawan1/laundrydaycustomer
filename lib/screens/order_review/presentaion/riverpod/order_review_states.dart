import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/order_review/data/models/payment_method_model.dart';
import 'package:laundryday/screens/order_review/data/models/payment_option_model.dart';

class DelivertTypeModel {
  final String title;
  final String description;
  final String deliveryType;
  final String image;
  DelivertTypeModel({
    required this.title,
    required this.description,
    required this.deliveryType,
    required this.image,
  });
}

class OrderReviewStates {
  bool isRecording;
  bool isLoading;
  List<DelivertTypeModel> deliveryTypes;
  DelivertTypeModel? selecteddeliveryType;
  List<PaymentOptionModel> paymentOptions;
  PaymentOptionModel? selectedPaymentOption;
  List<ItemVariation> items;
  OrderReviewStates({
    required this.paymentOptions,
    this.selecteddeliveryType,
    this.selectedPaymentOption,
    required this.deliveryTypes,
    required this.isLoading,
    required this.items,
    required this.isRecording,
  });

  OrderReviewStates copyWith(
      {PaymentMethodModel? selectedPaymentMethod,
      List<PaymentOptionModel>? paymentOptions,
      PaymentOptionModel? selectedPaymentOption,
      List<ItemVariation>? items,
      List<DelivertTypeModel>? deliveryTypes,
      DelivertTypeModel? selecteddeliveryType,
      bool? isRecording,
      bool? isLoading}) {
    return OrderReviewStates(
      selectedPaymentOption:
          selectedPaymentOption ?? this.selectedPaymentOption,
      paymentOptions: paymentOptions ?? this.paymentOptions,
      selecteddeliveryType: selecteddeliveryType ?? this.selecteddeliveryType,
      deliveryTypes: deliveryTypes ?? this.deliveryTypes,
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      isRecording: isRecording ?? this.isRecording,
    );
  }
}

