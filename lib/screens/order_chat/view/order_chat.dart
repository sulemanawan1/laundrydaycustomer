import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/screens/order_chat/provider/order_chat_notifier.dart';
import 'package:laundryday/screens/order_chat/provider/order_chat_states.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_loader.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:voice_message_package/voice_message_package.dart';

import 'package:laundryday/core/constants/colors.dart';

final orderStateProvider =
    StateNotifierProvider.autoDispose<OrderChatNotifier, OrderChatStates?>(
        (ref) => OrderChatNotifier());

class OrderChat extends ConsumerStatefulWidget {
  const OrderChat({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderChatState createState() => _OrderChatState();
}

class _OrderChatState extends ConsumerState<OrderChat> {
  late List<ChatModel> chatList;
  late AudioRecorder audioRecord;
  final recieverColor = const Color.fromARGB(255, 227, 255, 247);

  @override
  void dispose() {
    super.dispose();
    audioRecord.dispose();
  }

  @override
  void initState() {
    super.initState();
    audioRecord = AudioRecorder();
    chatList = [
      ChatModel(
        id: 1,
        type: 'text',
        content: 'Hello, How r u?',
        senderId: 1,
        recieverId: 2,
        chatRoomId: 1,
        timeStamp: '2:49 Pm',
      ),
      ChatModel(
        id: 1,
        type: 'text',
        content: 'Fine. Whats about u.',
        senderId: 2,
        recieverId: 1,
        chatRoomId: 1,
        timeStamp: '2:49 Pm',
      ),
      ChatModel(
          id: 3,
          type: 'text',
          content: 'I am good, thank you! ',
          senderId: 1,
          recieverId: 2,
          chatRoomId: 1,
          timeStamp: "2:49 Pm"),
      ChatModel(
          id: 4,
          type: 'voice',
          content: 'Nice weather today!',
          senderId: 1,
          recieverId: 2,
          chatRoomId: 1,
          voicePath: 'assets/sounds/3778 Al Mahani St - حي الحزم.m4a',
          timeStamp: "2:49 Pm"),
      ChatModel(
          id: 4,
          type: 'voice',
          content: 'Nice weather today!',
          senderId: 2,
          recieverId: 1,
          chatRoomId: 1,
          voicePath: 'assets/sounds/3778 Al Mahani St - حي الحزم.m4a',
          timeStamp: "2:49 Pm"),
      ChatModel(
          id: 5,
          type: 'image',
          senderId: 1,
          recieverId: 2,
          chatRoomId: 1,
          imgPath: 'assets/clothes_1.jpg',
          timeStamp: "2:49 Pm"),
      ChatModel(
          id: 5,
          type: 'image',
          senderId: 2,
          recieverId: 1,
          chatRoomId: 1,
          imgPath: 'assets/clothes_2.jpg',
          timeStamp: "2:49 Pm"),
      ChatModel(
          id: 5,
          type: 'text',
          content: 'What are you doing right now?',
          senderId: 2,
          recieverId: 1,
          chatRoomId: 1,
          timeStamp: "2:49 Pm"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final states = ref.watch(orderStateProvider);

    return Scaffold(
      appBar: MyAppBar(title: 'Suleman Abrar'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: chatList.length,
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                if (chatList[index].type.contains('text')) {
                  return Row(
                    mainAxisAlignment: (chatList[index].senderId == 1)
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: (chatList[index].senderId == 1)
                                ? ColorManager.whiteColor
                                : recieverColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              chatList[index].content.toString(),
                              style: GoogleFonts.poppins(),
                            ),
                            Text(
                              chatList[index].timeStamp.toString(),
                              style: GoogleFonts.poppins(
                                  color: ColorManager.greyColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (chatList[index].type.contains('voice')) {
                  return Row(
                    mainAxisAlignment: (chatList[index].senderId == 1)
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: VoiceMessageView(
                              backgroundColor: (chatList[index].senderId == 1)
                                  ? ColorManager.whiteColor
                                  : recieverColor,
                              activeSliderColor: ColorManager.primaryColor,
                              circlesColor: ColorManager.primaryColor,
                              controller: VoiceController(
                                audioSrc:
                                    'https://dl.musichi.ir/1401/06/21/Ghors%202.mp3',
                                maxDuration: const Duration(seconds: 20),
                                isFile: false,
                                onComplete: () {
                                  /// do something on complete
                                },
                                onPause: () {
                                  /// do something on pause
                                },
                                onPlaying: () {
                                  /// do something on playing
                                },
                                onError: (err) {
                                  /// do somethin on error
                                },
                              ),
                              innerPadding: 12,
                              cornerRadius: 20,
                              size: 38,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              child: Text(
                                chatList[index].timeStamp.toString(),
                                style: GoogleFonts.poppins(
                                    color: ColorManager.greyColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (chatList[index].type.contains('image')) {
                  return Row(
                    mainAxisAlignment: (chatList[index].senderId == 1)
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                              chatList[index].imgPath.toString(),
                            )),
                            borderRadius: BorderRadius.circular(8),
                            color: (chatList[index].senderId == 1)
                                ? ColorManager.whiteColor
                                : recieverColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            3.ph,
                            Text(
                              chatList[index].timeStamp.toString(),
                              style: GoogleFonts.poppins(
                                  color: ColorManager.greyColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return const Loader();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: SizedBox(
              height: 80,
              child: TextFormField(
                readOnly: states!.isRecording ? true : false,
                controller:
                    ref.read(orderStateProvider.notifier).textController,
                maxLines: null,
                decoration: InputDecoration(
                  prefixIconConstraints:
                      const BoxConstraints(maxWidth: 100, minWidth: 100),
                  prefixIcon: Row(
                    children: [
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            showDialogPhoto(context);
                          },
                          icon: Icon(
                            Icons.photo_camera,
                            color: ColorManager.greyColor,
                          )),
                      states.isRecording
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: stopRecording,
                              icon: const Icon(Icons.stop))
                          : IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: startRecording,
                              icon: Icon(
                                Icons.mic,
                                color: ColorManager.greyColor,
                              ))
                    ],
                  ),
                  filled: true,
                  fillColor: ColorManager.whiteColor,
                  hintText: "Write message...",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.greyColor),
                      borderRadius: BorderRadius.circular(40)),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.send,
                      color: ColorManager.greyColor,
                    ),
                    onPressed: () {
                      ref.read(orderStateProvider.notifier).clearText();
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void stopRecording() async {
    ref.read(orderStateProvider.notifier).recordingStatus(input: false);

    await audioRecord.stop();
  }

  void startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        ref.read(orderStateProvider.notifier).recordingStatus(input: true);
        Directory documentDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentDirectory.path,
            '${DateTime.now().microsecondsSinceEpoch}.m4a');
        await audioRecord.start(const RecordConfig(), path: path);
      }
    } catch (e, stackTrace) {
      log(stackTrace.toString());
    }
  }

  Future<dynamic> showDialogPhoto(BuildContext context) {
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
                  'Choose Photo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                20.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primaryColor),
                      icon: const Icon(
                        Icons.camera,
                      ),
                      onPressed: () async {
                        await ref
                            .read(orderStateProvider.notifier)
                            .pickImage(imageSource: ImageSource.camera);

                        context.pop();
                      },
                      label: const Text('Camera'),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primaryColor),
                      icon: const Icon(Icons.image),
                      onPressed: () async {
                        await ref
                            .read(orderStateProvider.notifier)
                            .pickImage(imageSource: ImageSource.gallery);
                        // ignore: use_build_context_synchronously
                        context.pop();
                      },
                      label: const Text('Gallery'),
                    ),
                  ],
                ),
                30.ph
              ],
            ),
          );
        });
  }
}

class ChatModel {
  final int id;
  final String type;
  final String? content;
  final String timeStamp;
  final int senderId;
  final int recieverId;
  final int chatRoomId;
  final String? imgPath;
  final String? voicePath;
  ChatModel({
    required this.id,
    required this.type,
    this.content,
    required this.timeStamp,
    required this.senderId,
    required this.recieverId,
    required this.chatRoomId,
    this.imgPath,
    this.voicePath,
  });

  ChatModel copyWith({
    int? id,
    String? type,
    ValueGetter<String?>? content,
    String? timeStamp,
    int? userId,
    int? recieverId,
    int? chatRoomId,
    ValueGetter<String?>? imgPath,
    ValueGetter<String?>? voicePath,
  }) {
    return ChatModel(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content != null ? content() : this.content,
      timeStamp: timeStamp ?? this.timeStamp,
      // ignore: unnecessary_this
      senderId: userId ?? this.senderId,
      recieverId: recieverId ?? this.recieverId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      imgPath: imgPath != null ? imgPath() : this.imgPath,
      voicePath: voicePath != null ? voicePath() : this.voicePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'content': content,
      'timeStamp': timeStamp,
      'userId': senderId,
      'recieverId': recieverId,
      'chatRoomId': chatRoomId,
      'imgPath': imgPath,
      'voicePath': voicePath,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id']?.toInt() ?? 0,
      type: map['type'] ?? '',
      content: map['content'],
      timeStamp: map['timeStamp'] ?? '',
      senderId: map['userId']?.toInt() ?? 0,
      recieverId: map['recieverId']?.toInt() ?? 0,
      chatRoomId: map['chatRoomId']?.toInt() ?? 0,
      imgPath: map['imgPath'],
      voicePath: map['voicePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(id: $id, type: $type, content: $content, timeStamp: $timeStamp, userId: $senderId, recieverId: $recieverId, chatRoomId: $chatRoomId, imgPath: $imgPath, voicePath: $voicePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.id == id &&
        other.type == type &&
        other.content == content &&
        other.timeStamp == timeStamp &&
        other.senderId == senderId &&
        other.recieverId == recieverId &&
        other.chatRoomId == chatRoomId &&
        other.imgPath == imgPath &&
        other.voicePath == voicePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        content.hashCode ^
        timeStamp.hashCode ^
        senderId.hashCode ^
        recieverId.hashCode ^
        chatRoomId.hashCode ^
        imgPath.hashCode ^
        voicePath.hashCode;
  }
}
