import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';

final vechileRegistrationImageProvider =
    StateNotifierProvider.autoDispose<VechileRegistrationImageNotifier, XFile?>(
        (ref) => VechileRegistrationImageNotifier());

class VechileRegistrationImageNotifier extends StateNotifier<XFile?> {
  VechileRegistrationImageNotifier() : super(null);

  pickImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource).then((value) {
      return state = value;
    });
  }
}
