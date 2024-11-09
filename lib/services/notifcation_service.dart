import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initFlutterNotificationPlugin(RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    var iosInitialization = const DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestCriticalPermission: true,
        requestSoundPermission: true);

    var initializeSetting = InitializationSettings(
        android: androidInitialization, iOS: iosInitialization);

    await flutterLocalNotificationsPlugin.initialize(initializeSetting,
        onDidReceiveNotificationResponse: (payload) async {
      handleMessages(message);
    });
  }

  fireBaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      initFlutterNotificationPlugin(message);
      showNotificationFlutter(message);
    });
  }

  Future<void> showNotification(String title, String body) async {
    // Android Channel Initialization
    AndroidNotificationChannel androidNotificationChannel =
        const AndroidNotificationChannel(
      "high_importance_channel",
      "high_importance_channel",
      description: "smart-gate-notification",
      importance: Importance.high,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            androidNotificationChannel.id, androidNotificationChannel.name,
            channelDescription: androidNotificationChannel.description,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0, title.toString(), body.toString(), notificationDetails);
    });
  }

  Future<void> showNotificationFlutter(RemoteMessage message) async {
    // Android Channel Initialization
    AndroidNotificationChannel androidNotificationChannel =
        const AndroidNotificationChannel(
      "high_importance_channel",
      "high_importance_channel",
      description: "smart-gate-notification",
      importance: Importance.high,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            androidNotificationChannel.id, androidNotificationChannel.name,
            channelDescription: androidNotificationChannel.description,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  requestNotification() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        sound: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('permission granted');
    }
    if (kDebugMode) {
      print('user granted provisional permission');
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  Future<String?> getDeviceToken() async {
    try {
      String? deviceToken = await firebaseMessaging.getToken();

      return deviceToken;
    } catch (e) {
      return null;
    }
  }

  refreshDeviceToken() async {
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  Future<void> setupInteractMessage() async {
    // when app is terminated
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      handleMessages(message);
    }

    // when app is running in background then this function is call
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessages(event);
    });
  }

  handleMessages(RemoteMessage message) async {
    // User user = await MySharedPreferences.getUserData();

    var type = message.data['type'].toString();
    var data = message.data['data'].toString();

    if (type == 'Order') {
      log(type);

      Map datas = jsonDecode(data);
    }

    //   Get.toNamed(noticeboardscreen, arguments: [user, resident]);
    // } else if (message.data['type'] == 'PreApproveEntry') {
    //   Get.toNamed(preapproveentryscreen, arguments: [user, resident]);
    // } else if (message.data['type'] == 'Report') {
    //   Get.toNamed(adminreports, arguments: [user, resident]);
    // } else if (message.data['type'] == 'ReportHistory') {
    //   Get.toNamed(reportshistoryscreen, arguments: [user, resident]);
    // }
  }
}
