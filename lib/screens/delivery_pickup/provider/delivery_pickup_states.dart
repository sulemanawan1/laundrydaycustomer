import 'package:image_picker/image_picker.dart';

class DeliveryPickupStates {
  XFile? image;
  double deliveryfees;
  bool isBlanketSelected;
  bool isCarpetSelected;
  bool? itemIncluded;
  bool itemsExempt;
  double additionalOperationFee;
  double additionalDeliveryFee;
  DeliveryPickupStates({
    required this.itemsExempt,
    this.itemIncluded,
    required this.deliveryfees,
    required this.additionalDeliveryFee,
    required this.additionalOperationFee,
    required this.isBlanketSelected,
    required this.isCarpetSelected,
    this.image,
  });

  DeliveryPickupStates copyWith({
      bool? itemsExempt,

    bool? itemIncluded,
    bool? isBlanketSelected,
    bool? isCarpetSelected,
    double? additionalOperationFee,
    double? additionalDeliveryFee,
    double? deliveryfees,
    XFile? image,
  }) {
    return DeliveryPickupStates(
      itemsExempt: itemsExempt??this.itemsExempt,
      itemIncluded: itemIncluded ?? this.itemIncluded,
      isBlanketSelected: isBlanketSelected ?? this.isBlanketSelected,
      isCarpetSelected: isCarpetSelected ?? this.isCarpetSelected,
      additionalDeliveryFee:
          additionalDeliveryFee ?? this.additionalDeliveryFee,
      additionalOperationFee:
          additionalOperationFee ?? this.additionalOperationFee,
      deliveryfees: deliveryfees ?? this.deliveryfees,
      image: image ?? this.image,
    );
  }
}
