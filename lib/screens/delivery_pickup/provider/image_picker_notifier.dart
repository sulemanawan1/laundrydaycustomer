import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';
import 'package:laundryday/models/blankets_model.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/colors.dart';

class ImagePickerNotifier extends StateNotifier<XFile?> {
  ImagePickerNotifier() : super(null);

  pickImage(
      {required ImageSource imageSource,
      required BuildContext context,
      required WidgetRef ref}) {
    ImagePickerHandler.pickImage(imageSource: imageSource).then((value) {
      log(value.toString());
      if (value != null) {
        ImageCropper().cropImage(
          sourcePath: value!.path,
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
            state = XFile(value.path);

            final imageId = DateTime.now().millisecondsSinceEpoch;

            ref.read(selectedDeliveryPickupItemProvider.notifier).addItem(
                item: LaundryItemModel(
                    name: 'receipt',
                    id: imageId,
                    image: ref.read(imagePickerProvider.notifier).state!.path));
          }
        }).onError((error, stackTrace) {
          log(error.toString());

          log(stackTrace.toString());
        });
      }

      return state;
    });
  }

  removeImage() {
    state = null;
  }
}
