import 'package:image_picker/image_picker.dart';

class OrderChatStates {
  XFile? image;
  bool isRecording;

  OrderChatStates({
    this.image,
    this.isRecording=false
  });

  OrderChatStates copyWith({
    XFile? image,
    bool isRecording=false,
  }) {
    return OrderChatStates(
      image: image ?? image,
      isRecording: isRecording
    );
  }
}
