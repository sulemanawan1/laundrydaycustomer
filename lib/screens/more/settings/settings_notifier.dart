import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/more/settings/setting_states.dart';
import 'package:permission_handler/permission_handler.dart';

final lanugaeProvider =
    StateNotifierProvider<SettingNotifier, SettingStates>(
        (ref) => SettingNotifier());

class SettingNotifier extends StateNotifier<SettingStates> {
  SettingNotifier()
      : super(SettingStates(
            savedLocale: null, locales: [Locale('en'), Locale('ar')])) {
    checkNotificationPermission();
  }

  getSavedLocale(BuildContext context) {
    state = state.copyWith(savedLocale: context.savedLocale!.languageCode);
  }

  setSavedLocale({required String locale}) {
    state = state.copyWith(savedLocale: locale);
  }

  Future<bool?> checkNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isGranted) {
      // Notifications are enabled
      print('Notification permission granted.');

      state = state.copyWith(pushNotifcation: true);
      return true;
    } else if (status.isDenied) {
      // Notification permission is denied
      print('Notification permission denied.');
      state = state.copyWith(pushNotifcation: false);

      return false;
    } else if (status.isPermanentlyDenied) {
      // Notification permission is permanently denied
      print(
          'Notification permission permanently denied. You might need to guide the user to app settings.');

      state = state.copyWith(pushNotifcation: false);

      return false;
    }
    return null;
  }
}
