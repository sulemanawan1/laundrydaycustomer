import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';

final rearVechileImageProvider =
    StateNotifierProvider.autoDispose<RearVechileImageNotifier, XFile?>(
        (ref) => RearVechileImageNotifier());

class RearVechileImageNotifier extends StateNotifier<XFile?> {
  RearVechileImageNotifier() : super(null);

  pickImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource).then((value) {
      return state = value;
    });
  }
}
