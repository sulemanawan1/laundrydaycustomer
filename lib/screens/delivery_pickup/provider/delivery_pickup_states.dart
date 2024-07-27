import 'package:image_picker/image_picker.dart';

import 'package:laundryday/models/item_model.dart';

class DeliveryPickupStates {
  ItemModel? laundryItemModel;
  XFile? image;
  double deliveryfees;
  DeliveryPickupStates({
  required  this.deliveryfees,
    this.laundryItemModel,
    this.image,
  });

  DeliveryPickupStates copyWith({
    ItemModel? laundryItemModel,
    List<ItemModel>? laundryItemList,
    List<ItemModel>? selectedItems,
      double? deliveryfees,

    XFile? image,
    int? quanitiy,

  }) {
    return DeliveryPickupStates(
      deliveryfees: deliveryfees??this.deliveryfees,
      laundryItemModel: laundryItemModel ?? this.laundryItemModel,
      image: image ?? this.image,
    );
  }
}

