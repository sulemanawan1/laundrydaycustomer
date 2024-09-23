import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/models/token_model.dart';
import 'package:laundryday/screens/order_chat/service/order_chat_service.dart';
import 'package:laundryday/services/image_picker_service.dart';
import 'package:laundryday/main.dart';
import 'package:laundryday/models/chat_model.dart';
import 'package:laundryday/screens/order_chat/provider/order_chat_states.dart';
import 'package:laundryday/services/send_notification_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

final orderchatProvider =
    StateNotifierProvider<OrderChatNotifier, OrderChatStates?>(
        (ref) => OrderChatNotifier());

enum ChatTypes { message, voice, image }

class OrderChatNotifier extends StateNotifier<OrderChatStates> {
  final OrderChatService _orderChatService = OrderChatService();
  TextEditingController textController = TextEditingController();
  late AudioRecorder audioRecord;
  late Timer timer;

  OrderChatNotifier()
      : super(OrderChatStates(
            tokens: [],
            hasText: false,
            uploading: false,
            recordingSeconds: 0,
            isRecording: false)) {}

  isHasText({required String val}) {
    if (val.trim().isNotEmpty) {
      state = state.copyWith(hasText: true);
    } else {
      state = state.copyWith(hasText: false);
    }
  }

  pickImage({
    required ImageSource imageSource,
    required String chatRoomId,
    required int userId,
    required BuildContext context,
  }) async {
    XFile? image = await ImagePickerService.pickImage(imageSource: imageSource);
    context.pop();
    if (image != null) {
      state = state.copyWith(image: File(image.path));

      try {
        state = state.copyWith(uploading: true);

        UploadTask uploadTask = FirebaseStorage.instance
            .ref('chats')
            .child('images/${image.path}')
            .putFile(state.image!);

        TaskSnapshot snapshot = await uploadTask;

        String url = await snapshot.ref.getDownloadURL();

        sendMessage(
            content: url,
            chatType: ChatTypes.image,
            chatRoomId: chatRoomId,
            userId: userId);
        state = state.copyWith(uploading: false);

        log(url);
      } catch (e) {
        print("Error uploading file: $e");
      }
    }
  }

  cancelTimer() {
    timer.cancel();
  }

  disposeRecording() {
    audioRecord.dispose();
  }

  void stopRecording() async {
    await audioRecord.stop();
    await audioRecord.cancel();
    timer.cancel();
    state = state.copyWith(isRecording: false, recordingSeconds: 0);
  }

  initlizeAudioRecorder() {
    audioRecord = AudioRecorder();
  }

  Future<String?> uploadContent({
    required File file,
    required String folderName,
    required String subFolderName,
  }) async {
    try {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref(folderName)
          .child('$subFolderName/${file.path}')
          .putFile(file);

      TaskSnapshot snapshot = await uploadTask;

      String url = await snapshot.ref.getDownloadURL();

      return url;
    } catch (e) {
      print("Error uploading file: $e");

      return null;
    }
  }

  void startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        Directory documentDirectory = await getApplicationDocumentsDirectory();

        String path = join(documentDirectory.path,
            '${DateTime.now().microsecondsSinceEpoch}.aac');

        await audioRecord.start(
            const RecordConfig(
              encoder: AudioEncoder.aacLc,
              bitRate: 64000, // Higher quality voice recording
              sampleRate: 22050,
            ),
            path: path);

        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          state.recordingSeconds++;

          state = state.copyWith(recordingSeconds: state.recordingSeconds);
          log('Recording Time :${state.recordingSeconds}');
          if (state.recordingSeconds >= 30) {
            stopRecording();
          }
        });

        state = state.copyWith(audioFile: File(path), isRecording: true);
      }
    } catch (e, stackTrace) {
      log(stackTrace.toString());
    }
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void sendMessage(
      {required int userId,
      required String chatRoomId,
      required ChatTypes chatType,
      required String content}) async {
    state = state.copyWith(hasText: false);
    ChatModel newMessage = ChatModel(
        id: uuid.v1(),
        chatRoomId: chatRoomId,
        senderId: userId.toString(),
        sentAt: DateTime.now(),
        chatType: chatType.name.toString(),
        content: content,
        seen: false);

    FirebaseFirestore.instance.collection("messages").add(newMessage.toMap());

    log("Messafge Sent!");

    if (state.tokens.isNotEmpty) {
      for (var token in state.tokens) {
        log("Tokens");

        log(token);
        SendNotificationService.sendNotificationUsingApi(
            token: token,
            title: ChatTypes.message.name,
            body: content,
            type: 'OrderChat',
            data: newMessage.toMap());
      }
    }
    log("Notification Sent!");
  }

  Stream<List<ChatModel>> getMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('chatRoomId', isEqualTo: chatRoomId)
        .orderBy('sentAt', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      return query.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return ChatModel.fromMap(data);
      }).toList();
    });
  }

  fcmTokens({
    required int userId,
  }) async {
    state = state.copyWith(tokens: []);

    Either<String, TokenModel> apiData =
        await _orderChatService.fcmTokens(userId: userId);

    apiData.fold((l) {
      log(l.toString());

      state = state.copyWith(tokens: []);
    }, (r) {
      state = state.copyWith(tokens: r.tokens);
    });
  }
}
