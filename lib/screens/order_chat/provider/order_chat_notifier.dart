import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/core/image_picker_handler.dart';
import 'package:laundryday/screens/order_chat/provider/order_chat_states.dart';

class OrderChatNotifier extends StateNotifier<OrderChatStates> {
  TextEditingController textController = TextEditingController();

  OrderChatNotifier() : super(OrderChatStates());

  pickImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource).then((value) {
      log(value.toString());

      state = state.copyWith(image: value);
    });
  }

  clearText() {
    textController.clear();
  }


  recordingStatus({required bool input})
  {

    state = state.copyWith(isRecording: input);


  }
}
