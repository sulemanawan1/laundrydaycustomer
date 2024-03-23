import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';
import 'package:laundryday/models/blankets_model.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/delivery_pickup/components/recieving_method_widget.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_states.dart';
import 'package:laundryday/screens/delivery_pickup/services/delivery_pickup_services.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:path/path.dart';

class DeliveryPickupNotifier extends StateNotifier<DeliveryPickupStates> {
  final deliveryPickupRepositoryProvider =
      Provider.autoDispose<DeliveryPickupRepository>((ref) {
    return DeliveryPickupRepository();
  });

  final Ref ref;
  DeliveryPickupNotifier({
    required this.ref,
  }) : super(DeliveryPickupStates(
            quanitiy: 0,
            selectedItems: [],
            laundryItemList: [],
            recievingMethod: RecievingMethodTypes.outsidedoor));

  fetchAllItems({required int? serviceId}) {
    ref
        .read(deliveryPickupRepositoryProvider)
        .getAllItems(serviceId: serviceId!)
        .then((value) {
      log(value.length.toString());

      state = state.copyWith(laundryItemList: value);
    });
  }

  selectBlanketItem({required LaundryItemModel laundryItem}) {
    state = state.copyWith(laundryItemModel: laundryItem);
  }

  resetItemAndQuantity() {
    state.laundryItemModel = null;
    state.quanitiy = 0;
    state = state.copyWith(
        laundryItemModel: state.laundryItemModel, quanitiy: state.quanitiy);
  }

  pickImage(
      {required ImageSource imageSource,
      required BuildContext context,
      required WidgetRef ref}) {
    ImagePickerHandler.pickImage(imageSource: imageSource).then((value) {
      log(value.toString());
      if (value != null) {
        ImageCropper().cropImage(
          sourcePath: value.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                activeControlsWidgetColor: ColorManager.primaryColor,
                toolbarTitle: 'Cropper',
                toolbarColor: ColorManager.primaryColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        ).then((value) {
          if (value != null) {
            state = state.copyWith(image: state.image = XFile(value.path));

            final iD = DateTime.now().millisecondsSinceEpoch;

            addItem(
                item: LaundryItemModel(
                    name: 'receipt', id: iD, image: state.image!.path));
          }
        }).onError((error, stackTrace) {
          log(error.toString());

          log(stackTrace.toString());
        });
      }
    });
  }

  removeImage() {
    state = state.copyWith(image: null);
  }

  addItem({required LaundryItemModel item}) {
    state.selectedItems!.add(item);
    state = state.copyWith(laundryItemList: state.laundryItemList);
  }

  deleteItem({required id}) {
    state.selectedItems!.removeWhere((element) => element.id == id);
    state = state.copyWith(laundryItemList: state.laundryItemList);
  }

  addQuantitiy({required ServicesModel servicesModel}) {
    if (servicesModel.id == 2) {
      if (state.quanitiy! >= 5) {
        state = state.copyWith(quanitiy: state.quanitiy = 5);
      } else {
        state = state.copyWith(quanitiy: state.quanitiy! + 1);
      }
    } else {
      if (state.quanitiy! >= 10) {
        state = state.copyWith(quanitiy: state.quanitiy = 10);
      } else {
        state = state.copyWith(quanitiy: state.quanitiy! + 1);
      }
    }
  }

  removeQuantitiy() {
    if (state.quanitiy! <= 0) {
      state = state.copyWith(quanitiy: state.quanitiy);
    } else {
      state = state.copyWith(quanitiy: state.quanitiy! - 1);
    }
  }

  selectRecievingMethod({required RecievingMethodTypes recievingMethodTypes}) {
    state = state.copyWith(recievingMethod: recievingMethodTypes);
  }



  goToOrderReview({required LaundryModel? laundryModel,required BuildContext context})

  {

    if (state.image== null) {
      Fluttertoast.showToast(msg: 'Please select Receipt.');
    } else {
      
      context.pushNamed(RouteNames().orderReview,
          extra: Arguments(
            laundryModel:laundryModel,
          ));
    }
  }
}
