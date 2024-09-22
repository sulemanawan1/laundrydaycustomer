import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/order_chat/provider/order_chat_notifier.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/services/resources/colors.dart';
import 'package:laundryday/services/resources/sized_box.dart';

chatImagePicker(BuildContext context, WidgetRef ref) {
  final userId = ref.read(userProvider).userModel!.user!.id;
  final chatRoomId =
      ref.read(orderProcessProvider).chatProfileModel!.chatRoomId;
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              10.ph,
              const Text(
                'Choose Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              20.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primaryColor),
                        icon: const Icon(
                          Icons.camera,
                        ),
                        onPressed: () async {
                          await ref.read(orderchatProvider.notifier).pickImage(
                              context: context,
                              imageSource: ImageSource.camera,
                              chatRoomId: chatRoomId,
                              userId: userId!);
                        },
                        label: const Text('Camera'),
                      ),
                    ),
                    5.pw,
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primaryColor),
                        icon: const Icon(Icons.image),
                        onPressed: () async {
                          await ref.read(orderchatProvider.notifier).pickImage(
                              context: context,
                              imageSource: ImageSource.gallery,
                              chatRoomId: chatRoomId,
                              userId: userId!);
                        },
                        label: const Text('Gallery'),
                      ),
                    ),
                  ],
                ),
              ),
              30.ph
            ],
          ),
        );
      });
}
