import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<XFile?> pickImage({
    required ImageSource imageSource,
  }) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: imageSource);

    if (image != null) {
      return image;
    }

    return null;
  }

  static Future<List<XFile?>> pickMultipleImages() async {
    final ImagePicker picker = ImagePicker();

    List<XFile> images =
        await picker.pickMultiImage(limit: 9, requestFullMetadata: true);

   
    return images;
  }
}
