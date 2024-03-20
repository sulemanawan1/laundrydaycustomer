import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';

final profilePictureProvider =
    StateNotifierProvider.autoDispose<ProfilePictureNotifier, XFile?>(
        (ref) => ProfilePictureNotifier());

class ProfilePictureNotifier extends StateNotifier<XFile?> {
  ProfilePictureNotifier() : super(null);

  pickImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource).then((value) {
      return state = value;
    });
  }
}
