import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';
import 'package:laundryday/screens/order_chat/provider/order_chat_notifier.dart';
import 'package:laundryday/screens/order_chat/widgets/chat_image_picker.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/constants/colors.dart';

class ChatTextField extends StatelessWidget {
  final WidgetRef ref;
  ChatTextField({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final textController = ref.read(orderchatProvider.notifier).textController;
    final userId = ref.read(userProvider).userModel!.user!.id;
    final chatRoomId =
        ref.read(orderProcessProvider).chatProfileModel!.chatRoomId;
    final receiverId =
        ref.read(orderProcessProvider).chatProfileModel!.receiverId;

    final hasText = ref.watch(orderchatProvider)!.hasText;

    return TextFormField(
      onChanged: (val) {
        ref.read(orderchatProvider.notifier).isHasText(val: val);
      },
      controller: ref.read(orderchatProvider.notifier).textController,
      maxLines: null,
      decoration: InputDecoration(
        prefixIconConstraints:
            const BoxConstraints(maxWidth: 100, minWidth: 100),
        prefixIcon: Row(
          children: [
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  chatImagePicker(context, ref);
                },
                icon: Icon(
                  Icons.photo_camera,
                  color: ColorManager.greyColor,
                )),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  ref.read(orderchatProvider.notifier).startRecording();
                },
                icon: Icon(
                  Icons.mic,
                  color: ColorManager.greyColor,
                ))
          ],
        ),
        filled: true,
        fillColor: ColorManager.whiteColor,
        hintText: "Write message...",
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.greyColor),
            borderRadius: BorderRadius.circular(40)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.nprimaryColor),
            borderRadius: BorderRadius.circular(40)),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.send,
            color:
                hasText ? ColorManager.nprimaryColor : ColorManager.greyColor,
          ),
          onPressed: () {
            String content = textController.text.trim();
            textController.clear();
            if (content.isNotEmpty) {
              ref.read(orderchatProvider.notifier).sendMessage(
                  content: content,
                  chatType: ChatTypes.message,
                  chatRoomId: chatRoomId,
                  userId: userId!);
            }
          },
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none),
      ),
    );
  }
}
