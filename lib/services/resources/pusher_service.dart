import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/services/resources/audio_player_service.dart';
import 'package:laundryday/services/resources/crypto_service.dart';
import 'package:laundryday/models/my_user_model.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  WidgetRef ref;
  UserModel userModel;
  final AudioPlayerService _audioPlayerHandler = AudioPlayerService();
  PusherService({required this.userModel, required this.ref});
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  initCLinet() async {
    try {
      await pusher.init(
        apiKey: 'af5133e4f08e8f69d3fc',
        cluster: 'ap2',
        // authEndpoint: "http://192.168.1.3:8000/api/broadcasting/auth",
        authParams: {
          'headers': {
            // 'Authorization':
            //     'Bearer 59|3FBXbZjKJOFsVxnqiDQP2udPG88kmJEhGLASaDEMdb236832',
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          }
        },
        onAuthorizer: onAuthorizer,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
      );
      await pusher.subscribe(
        channelName: 'private-order-status.${userModel.user!.id}',
      );

      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  onOrderStatusSubscribe({required int orderId}) async {
    await pusher.subscribe(
      channelName: 'private-order-status.${orderId}',
    );
  }

  onAuthorizer(String channelName, String socketId, dynamic options) async {
    var message = "$socketId:$channelName";
    var secret = '6fac319f72f254ae38da';

    var signature = CryptoService.computeHmacSha256(secret, message);

    var pusherKey = "af5133e4f08e8f69d3fc";
    var authKey = '$pusherKey:${signature.toString()}';

    log(authKey);

    return {
      "auth": authKey,
      "shared_secret": secret.toString(),
    };
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName member: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName member: $member");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onEvent(PusherEvent event) async {
    log("onEvent: ${event.data}");

    // OrderPickupModel order = orderPickupModelFromJson(event.data.toString());

    OrderModel order = orderModelFromJson(event.data.toString());

    if (order.order?.id != null) {
      ref.read(orderProcessProvider.notifier).updaterOrder(order: order);

      _audioPlayerHandler.iniializeAudioPlayer();
      _audioPlayerHandler.playAssetSound(
          audioPath: 'audios/mixkit-bell-notification-933.wav');
    }
    // if (order.order?.id != null) {
    //   ref.read(orderRequestProvider.notifier).addOrder(order: order);

    // }
    // strings.add(data);

    // showNotification("New Message", data.toString());
    // showNotification("New Order", data.toString());
    // setState(() {});
  }
}
