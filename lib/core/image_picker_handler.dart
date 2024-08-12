import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  static Future<XFile?> pickImage({
    required ImageSource imageSource,
  }) async {
    final ImagePicker picker = ImagePicker();

    log(picker.toString());

    final XFile? image = await picker.pickImage(source: imageSource);

    log(image.toString());
    if (image != null) {
      return image;
    }

    return null;
  }

  static Future<List<XFile?>> pickMultipleImages() async {
    final ImagePicker picker = ImagePicker();

    List<XFile> images = await picker.pickMultiImage();

    return images;
  }
}
