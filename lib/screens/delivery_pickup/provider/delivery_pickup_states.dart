import 'package:image_picker/image_picker.dart';

import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';

class DeliveryPickupStates {
  ItemModel? laundryItemModel;
  List<ItemModel>? laundryItemList;
  List<ItemModel>? selectedItems;
  RecievingMethodTypes? recievingMethod;
  XFile? image;
  int? quanitiy;
  DeliveryPickupStates(
      {this.laundryItemModel,
      this.laundryItemList,
      this.selectedItems,
      this.image,
      this.quanitiy,
      this.recievingMethod});

  DeliveryPickupStates copyWith({
    ItemModel? laundryItemModel,
    List<ItemModel>? laundryItemList,
    List<ItemModel>? selectedItems,
    RecievingMethodTypes? recievingMethod,
    XFile? image,
    int? quanitiy,
  }) {
    return DeliveryPickupStates(
        laundryItemModel: laundryItemModel ?? this.laundryItemModel,
        laundryItemList: laundryItemList ?? this.laundryItemList,
        selectedItems: selectedItems ?? this.selectedItems,
        image: image ?? this.image,
        quanitiy: quanitiy ?? this.quanitiy,
        recievingMethod: recievingMethod ?? this.recievingMethod);
  }
}
