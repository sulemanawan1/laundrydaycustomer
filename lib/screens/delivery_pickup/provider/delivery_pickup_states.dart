import 'package:image_picker/image_picker.dart';


class DeliveryPickupStates {
  XFile? image;
  double deliveryfees;
  bool isBlanketSelected;
  bool isCarpetSelected;
  double additionalOperationFee;
  double additionalDeliveryFee;
  DeliveryPickupStates({
  required  this.deliveryfees,
    required this.additionalDeliveryFee,
    required this.additionalOperationFee,
    required this.isBlanketSelected,
    required this.isCarpetSelected,
    this.image,
  });

  DeliveryPickupStates copyWith({
     bool? isBlanketSelected,
    bool? isCarpetSelected,
    double? additionalOperationFee,
    double? additionalDeliveryFee,
      double? deliveryfees,
      

    XFile? image,

  }) {
    return DeliveryPickupStates(
      isBlanketSelected: isBlanketSelected ?? this.isBlanketSelected,
      isCarpetSelected: isCarpetSelected ?? this.isCarpetSelected,
      additionalDeliveryFee:
          additionalDeliveryFee ?? this.additionalDeliveryFee,
      additionalOperationFee:
          additionalOperationFee ?? this.additionalOperationFee,
      deliveryfees: deliveryfees??this.deliveryfees,
      image: image ?? this.image,
    );
  }
}

