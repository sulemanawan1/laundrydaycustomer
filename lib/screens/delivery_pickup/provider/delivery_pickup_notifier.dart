import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/core/image_picker_handler.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_states.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/routes/route_names.dart';

class DeliveryPickupNotifier extends StateNotifier<DeliveryPickupStates> {
  final Ref ref;
  DeliveryPickupNotifier({
    required this.ref,
  }) : super(DeliveryPickupStates(
          deliveryfees: 0.0,
          additionalDeliveryFee: 0.0,
          additionalOperationFee: 0.0,
          isBlanketSelected: false,
          isCarpetSelected: false,
        ));

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
          }
        }).onError((error, stackTrace) {
          log(error.toString());

          log(stackTrace.toString());
        });
      }
    });
  }

  goToOrderReview({
    required BuildContext context,
  }) {
    if (state.image == null) {
      Fluttertoast.showToast(msg: 'Please select Receipt.');
    } else {
      {}
      context.pushNamed(RouteNames.orderReview, extra: {
        'order_type': OrderType.delivery_pickup,
      });
    }
  }


  void updateFees() {
    state.additionalOperationFee = (state.isBlanketSelected ? 5.0 : 0.0) +
        (state.isCarpetSelected ? 5.0 : 0.0);
    state.additionalDeliveryFee = (state.isBlanketSelected ? 2.0 : 0.0) +
        (state.isCarpetSelected ? 2.0 : 0.0);
    state = state.copyWith(
        additionalDeliveryFee: state.additionalDeliveryFee,
        additionalOperationFee: state.additionalOperationFee);
  }

  selectCarpet({required bool isSelected}) {
    state.isCarpetSelected = isSelected;

    state = state.copyWith(isCarpetSelected: state.isCarpetSelected);
  }

  selectBlanket({required bool isSelected}) {
    state.isBlanketSelected = isSelected;

    state = state.copyWith(isBlanketSelected: state.isBlanketSelected);
  }

  // setDeliveryFee(
  //     {required double distance,
  //     required double deliveryfee,
  //     required double operationfee}) {
  //   state = state.copyWith(deliveryfees: deliveryfee + operationfee);
  // }
}
