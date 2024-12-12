import 'package:image_picker/image_picker.dart';

class DeliveryPickupStates {
  XFile? image;

  DeliveryPickupStates({
    this.image,
  });

  DeliveryPickupStates copyWith({
    XFile? image,
  }) {
    return DeliveryPickupStates(
      image: image ?? this.image,
    );
  }
}
