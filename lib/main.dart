import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/services/notifcation_service.dart';
import 'package:laundryday/firebase_options.dart';
import 'package:laundryday/config/theme/theme_manager.dart';
import 'package:uuid/uuid.dart';
import 'config/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  log("Handling a background message: ${message.data['type']}");
  log("Handling a background message: ${message.data['data']}");
}

var uuid = Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterNotificationChannel.registerNotificationChannel(
    description: 'Your channel description',
    id: 'high_importance_channel',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Popup Notification',
    visibility: NotificationVisibility.VISIBILITY_PUBLIC,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  NotificationService notificationServices = NotificationService();
  notificationServices.requestNotification();
  notificationServices.fireBaseInit();
  notificationServices.setupInteractMessage();
  String? token = await notificationServices.getDeviceToken();

  log("Fcm Token Firebase $token");

  runApp(ProviderScope(
      child: EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: Locale('en'),
          child: MyApp())));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor:
        Color.fromRGBO(242, 242, 242, 1), // Set the status bar color here
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter routes = ref.read(goRouterProvider);

    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: BotToastInit(),
      debugShowCheckedModeBanner: false,
      routerConfig: routes,
      theme: getApplicatonTheme(),
    );
  }
}






