import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';

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

  List<ItemVariation> items;
  OrderReviewStates({
    this.selecteddeliveryType,
    required this.deliveryTypes,
    required this.isLoading,
    required this.items,
    required this.isRecording,
  });

  OrderReviewStates copyWith(
      {PaymentMethods? selectedPaymentMethod,
      List<ItemVariation>? items,
      List<DelivertTypeModel>? deliveryTypes,
        DelivertTypeModel? selecteddeliveryType,

      bool? isRecording,
      bool? isLoading}) {
    return OrderReviewStates(
      selecteddeliveryType: selecteddeliveryType??this.selecteddeliveryType,
      deliveryTypes: deliveryTypes ?? this.deliveryTypes,
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
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
