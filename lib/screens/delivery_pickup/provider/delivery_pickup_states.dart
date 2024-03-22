import 'package:image_picker/image_picker.dart';

import 'package:laundryday/models/blankets_model.dart';

class DeliveryPickupStates {
  LaundryItemModel? laundryItemModel;
  List<LaundryItemModel>? laundryItemList;
  List<LaundryItemModel>? selectedItemds;
  XFile? image;
  int? quanitiy;
  DeliveryPickupStates({
    this.laundryItemModel,
    this.laundryItemList,
    this.selectedItemds,
    this.image,
    this.quanitiy,
  });

  DeliveryPickupStates copyWith({
   LaundryItemModel? laundryItemModel,
    List<LaundryItemModel>?laundryItemList,
   List<LaundryItemModel>? selectedItemds,
    XFile? image,
   int? quanitiy,
  }) {
    return DeliveryPickupStates(

      laundryItemModel: laundryItemModel ?? this.laundryItemModel,
      laundryItemList: laundryItemList ?? this.laundryItemList,
      selectedItemds: selectedItemds ?? this.selectedItemds,
      image: image ?? this.image,
      quanitiy: quanitiy ?? this.quanitiy,
    );
  }
}
