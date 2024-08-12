import 'package:image_picker/image_picker.dart';


class DeliveryPickupStates {
  XFile? image;
  double deliveryfees;

  DeliveryPickupStates({
  required  this.deliveryfees,
    this.image,
  });

  DeliveryPickupStates copyWith({
      double? deliveryfees,

    XFile? image,
    int? quanitiy,

  }) {
    return DeliveryPickupStates(
      deliveryfees: deliveryfees??this.deliveryfees,
      image: image ?? this.image,
    );
  }
}

