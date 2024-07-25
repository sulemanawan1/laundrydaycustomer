import 'package:image_picker/image_picker.dart';

import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/laundries/model/google_distance_matrix_model.dart';

class DeliveryPickupStates {
  ItemModel? laundryItemModel;
  List<ItemModel>? laundryItemList;
  List<ItemModel>? selectedItems;
  XFile? image;
  int? quanitiy;
  DeliveryPickupStates({
    this.laundryItemModel,
    this.laundryItemList,
    this.selectedItems,
    this.image,
    this.quanitiy,
  });

  DeliveryPickupStates copyWith({
    ItemModel? laundryItemModel,
    List<ItemModel>? laundryItemList,
    List<ItemModel>? selectedItems,
    XFile? image,
    int? quanitiy,
  }) {
    return DeliveryPickupStates(

        laundryItemModel: laundryItemModel ?? this.laundryItemModel,
        laundryItemList: laundryItemList ?? this.laundryItemList,
        selectedItems: selectedItems ?? this.selectedItems,
        image: image ?? this.image,
        quanitiy: quanitiy ?? this.quanitiy);
  }
}

// abstract class DeliveryPickupAddressesState {}

// class DeliveryPickupAddressesInittialState
//     extends DeliveryPickupAddressesState {}

// class DeliveryPickupAddressesLoadingState
//     extends DeliveryPickupAddressesState {}

// class DeliveryPickupAddressesErrorState extends DeliveryPickupAddressesState {
//   final String errorMessage;
//   DeliveryPickupAddressesErrorState({required this.errorMessage});
// }

// class DeliveryPickupAddressesLoadedState extends DeliveryPickupAddressesState {
//   GoogleDistanceMatrixModel googleDistanceMatrixModel;
//   DeliveryPickupAddressesLoadedState({required this.googleDistanceMatrixModel});
// }
