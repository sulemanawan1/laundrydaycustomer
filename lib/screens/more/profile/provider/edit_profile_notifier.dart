import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/screens/more/profile/provider/edit_profile_states.dart';
import 'package:laundryday/screens/more/profile/provider/profile_notifier.dart';
import 'package:laundryday/services/image_picker_service.dart';

final editProfileProvider =
    StateNotifierProvider.autoDispose<EditProfileNofifier, EditProfileStates>(
        (ref) {
  return EditProfileNofifier();
});

class EditProfileNofifier extends StateNotifier<EditProfileStates> {
  EditProfileNofifier()
      : super(EditProfileStates(
            profileUpdateStates: ProfileUpdateIntitialState()));
  final TextEditingController fullNameController = TextEditingController();

  updateUser(
      {required Map data,
      Map? files,
      required WidgetRef ref,
      required BuildContext context}) async {
        
    Either<String, UserModel> apiData =
        await ref.read(getUserProfileApi).updateUser(data: data, files: files);

    apiData.fold((l) {}, (r) {
      ref.invalidate(userProfileProvider);
      Utils.showToast(msg: 'Proflie Update');
      context.pop();
    });
  }

  pickImage(
      {required ImageSource imageSource,
      required BuildContext context,
      required WidgetRef ref}) {
    ImagePickerService.pickImage(imageSource: imageSource).then((value) {
      log(value.toString());
      if (value != null) {
        ImageCropper().cropImage(
          sourcePath: value.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
          ],
          uiSettings: [
            AndroidUiSettings(
                hideBottomControls: true,
                showCropGrid: false,
                toolbarTitle: '',
                toolbarColor: Colors.black,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: '',
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
}
