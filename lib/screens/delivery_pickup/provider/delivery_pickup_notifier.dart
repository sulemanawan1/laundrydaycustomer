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
import 'package:laundryday/screens/laundries/model/delivery_pickup_laundry_model.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/screens/services/model/services_model.dart' as s;

class DeliveryPickupNotifier extends StateNotifier<DeliveryPickupStates> {
  final Ref ref;
  DeliveryPickupNotifier({
    required this.ref,
  }) : super(DeliveryPickupStates(
          deliveryfees: 0.0,
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

  goToOrderReview(
      {required BuildContext context,
      required s.Datum service,
      required DeliveryPickupLaundryModel laundry}) {
    if (state.image == null) {
      Fluttertoast.showToast(msg: 'Please select Receipt.');
    } else {
      {}
      context.pushNamed(RouteNames().orderReview, extra: {
        'order_type': OrderType.delivery_pickup,
        'laundry': laundry,
        'service': service
      });
    }
  }

  setDeliveryFee({required double distance, required double deliveryfee}) {
    state = state.copyWith(deliveryfees: distance * deliveryfee);
  }
}
