import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/services/just_audio_service.dart';
import 'package:laundryday/widgets/custom_cache_netowork_image.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/helpers/date_helper.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/order_chat/provider/order_chat_notifier.dart';
import 'package:laundryday/screens/order_chat/widgets/chat_textfield.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/screens/services/view/services.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:voice_message_package/voice_message_package.dart';

class OrderChat extends ConsumerStatefulWidget {
  const OrderChat({
    super.key,
  });

  @override
  _OrderChatState createState() => _OrderChatState();
}

class _OrderChatState extends ConsumerState<OrderChat>
    with TickerProviderStateMixin {
  @override
  void dispose() {
    super.dispose();
    if (context.mounted) {
      ref.read(orderchatProvider.notifier).cancelTimer();
      ref.read(orderchatProvider.notifier).disposeRecording();
    }
  }

  @override
  void initState() {
    super.initState();

    ref.read(orderchatProvider.notifier).initlizeAudioRecorder();

    Future.delayed(Duration(seconds: 0), () {
      final reciverId =
          ref.read(orderProcessProvider).chatProfileModel!.receiverId;
      ref.read(orderchatProvider.notifier).fcmTokens(userId: reciverId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(userProvider).userModel!.user!.id;
    final chatRoomId =
        ref.read(orderProcessProvider).chatProfileModel!.chatRoomId;
    final chatProfile = ref.read(orderProcessProvider).chatProfileModel;

    return Scaffold(
      body: Column(
        children: [
          40.ph,
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios,
                    color: ColorManager.nprimaryColor),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.nprimaryColor,
                  border: Border.all(color: ColorManager.whiteColor),
                  image: DecorationImage(image: AssetImage(AssetImages.user)),
                ),
              ),
              12.pw,
              Text(
                  style: getSemiBoldStyle(color: ColorManager.blackColor),
                  "${chatProfile!.firstName.toString()} ${chatProfile.lastName.toString()} ")
            ],
          ),
          5.ph,
          Expanded(
            child: StreamBuilder(
                stream: ref
                    .read(orderchatProvider.notifier)
                    .getMessages(chatRoomId),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.active) {
                    if (snapshots.hasData) {
                      var chatList = snapshots.data!;

                      return ListView.builder(
                        reverse: true,
                        itemCount: chatList.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool isSender =
                              (chatList[index].senderId == userId.toString());

                          print(chatList[index].sentAt);

                          if (chatList[index]
                              .chatType!
                              .contains(ChatTypes.message.name)) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 2),
                              child: Column(
                                crossAxisAlignment: isSender
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: isSender
                                            ? ColorManager.nprimaryColor
                                            : ColorManager.greyColor),
                                    child: Text(
                                      chatList[index].content.toString(),
                                      style: getRegularStyle(
                                          fontSize: 14,
                                          color: ColorManager.whiteColor),
                                    ),
                                  ),
                                  5.ph,
                                  Text(
                                    DateHelper.convertTimeToAmPm(
                                        chatList[index].sentAt.toString()),
                                    style: getRegularStyle(
                                        color: ColorManager.greyColor),
                                  ),
                                ],
                              ),
                            );
                          } else if (chatList[index]
                              .chatType!
                              .contains(ChatTypes.voice.name)) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p10,
                                vertical: AppPadding.p10,
                              ),
                              child: Row(
                                mainAxisAlignment: isSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      VoiceMessageView(
                                        backgroundColor:
                                            ColorManager.silverWhite,
                                        activeSliderColor: isSender
                                            ? ColorManager.nprimaryColor
                                            : ColorManager.greyColor,
                                        circlesColor: isSender
                                            ? ColorManager.nprimaryColor
                                            : ColorManager.greyColor,
                                        controller: VoiceController(
                                          audioSrc: chatList[index]
                                              .content
                                              .toString(),
                                          maxDuration:
                                              const Duration(seconds: 30),
                                          isFile: false,
                                          onComplete: () {},
                                          onPause: () {},
                                          onPlaying: () {},
                                          onError: (err) {},
                                        ),
                                        innerPadding: 12,
                                        cornerRadius: 20,
                                        size: 38,
                                      ),
                                      5.ph,
                                      Text(
                                        DateHelper.convertTimeToAmPm(
                                            chatList[index].sentAt.toString()),
                                        style: getRegularStyle(
                                            color: ColorManager.greyColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else if (chatList[index]
                              .chatType!
                              .contains(ChatTypes.image.name)) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment: isSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        child: CustomCacheNetworkImage(
                                          imageUrl: chatList[index]
                                              .content
                                              .toString(),
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 2,
                                        right: 2,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: ColorManager.whiteColor),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 2),
                                              child: Text(
                                                DateHelper.convertTimeToAmPm(
                                                    chatList[index]
                                                        .sentAt
                                                        .toString()),
                                                style: getRegularStyle(
                                                    fontSize: 8,
                                                    color: ColorManager
                                                        .blackColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          } else {
                            return const Loader();
                          }
                        },
                      );
                    } else if (snapshots.hasError) {
                      return Center(child: Text(snapshots.error.toString()));
                    } else {
                      return const Loader();
                    }
                  } else {
                    return const Loader();
                  }
                }),
          ),
          Consumer(builder: (context, ref, child) {
            bool uploading = ref.watch(orderchatProvider)!.uploading;

            return uploading
                ? ChatUploading()
                : ChatRecoder(
                    ref: ref,
                  );
          }),
        ],
      ),
    );
  }
}

class ChatUploading extends StatelessWidget {
  const ChatUploading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p10, vertical: AppPadding.p10),
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.nprimaryColor,
            border: Border.all(color: ColorManager.greyColor),
            borderRadius: BorderRadius.circular(AppSize.s40)),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p14, vertical: AppPadding.p14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sending.....',
                style: getSemiBoldStyle(
                    color: ColorManager.whiteColor, fontSize: FontSize.s12),
              ),
              SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: CircularProgressIndicator(
                  color: ColorManager.whiteColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChatRecoder extends StatelessWidget {
  final WidgetRef ref;
  ChatRecoder({
    required this.ref,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isRecording = ref.watch(orderchatProvider)!.isRecording;
    final recordingSeconds = ref.watch(orderchatProvider)!.recordingSeconds;
    final audioFile = ref.read(orderchatProvider)!.audioFile;
    final userId = ref.read(userProvider).userModel!.user!.id;
    final chatRoomId =
        ref.read(orderProcessProvider).chatProfileModel!.chatRoomId;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p10, vertical: AppPadding.p10),
      child: isRecording
          ? Container(
              decoration: BoxDecoration(
                  color: ColorManager.nprimaryColor,
                  border: Border.all(color: ColorManager.greyColor),
                  borderRadius: BorderRadius.circular(AppSize.s40)),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        ref.read(orderchatProvider.notifier).stopRecording();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: ColorManager.whiteColor,
                      )),
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Text(
                          ref
                              .read(orderchatProvider.notifier)
                              .formatTime(recordingSeconds),
                          style:
                              getSemiBoldStyle(color: ColorManager.whiteColor),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            ref
                                .read(orderchatProvider.notifier)
                                .stopRecording();

                            if (audioFile != null) {
                              String? url = await ref
                                  .read(orderchatProvider.notifier)
                                  .uploadContent(
                                      file: audioFile,
                                      folderName: 'chats',
                                      subFolderName: 'recordings');

                              if (url != null) {
                                ref
                                    .read(orderchatProvider.notifier)
                                    .sendMessage(
                                        content: url,
                                        chatType: ChatTypes.voice,
                                        chatRoomId: chatRoomId,
                                        userId: userId!);
                              }
                            }
                          },
                          icon: Icon(
                            Icons.arrow_upward,
                            color: ColorManager.whiteColor,
                          )),
                      20.pw
                    ],
                  )
                ],
              ),
            )
          : ChatTextField(ref: ref),
    );
  }
}
