import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/screens/more/settings/settings_notifier.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:restart_app/restart_app.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      ref.read(lanugaeProvider.notifier).getSavedLocale(context);
    });
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        // Do something when the app is visible...
        break;
      case AppLifecycleState.hidden: // <-- This is the new state.
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        // Do something when the app is not visible...
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var lng = ref.watch(lanugaeProvider).locales;
    var savedLocale = ref.watch(lanugaeProvider).savedLocale;
    var pushNotifcation = ref.watch(lanugaeProvider).pushNotifcation;
    // ref.read(lanugaeProvider.notifier).checkNotificationPermission();
    return Scaffold(
      appBar: MyAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          10.ph,
          const Heading(title: 'Notifications'),
          ListTile(
            title: Text('Recieve Push Notification'),
            trailing: Switch(
                inactiveThumbColor: ColorManager.whiteColor,
                inactiveTrackColor: ColorManager.greyColor,
                value: pushNotifcation ?? false,
                onChanged: (val) async {
                  await AppSettings.openAppSettings(
                      type: AppSettingsType.notification);
                }),
          ),
          ListTile(
            title: Text('Offers Notifications'),
            trailing: Switch(
                inactiveThumbColor: ColorManager.whiteColor,
                inactiveTrackColor: ColorManager.greyColor,
                value: false,
                onChanged: (val) async {
                  await AppSettings.openAppSettings(
                      type: AppSettingsType.notification);
                }),
          ),
          10.ph,
          const Heading(title: 'Languages'),
          20.ph,
          Expanded(
            child: ListView.separated(
              separatorBuilder: ((context, index) => 10.ph),
              itemCount: lng.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: ColorManager.primaryColor)),
                  child: ListTile(
                    onTap: () {
                      print(savedLocale);
                      print(lng[index].languageCode);

                      ref
                          .read(lanugaeProvider.notifier)
                          .setSavedLocale(locale: lng[index].languageCode);
                    },
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Icon(Icons.radio_button_checked,
                          color: savedLocale == lng[index].languageCode
                              ? ColorManager.primaryColor
                              : ColorManager.greyColor),
                    ),
                    title: Text(
                      lng[index].languageCode.toString(),
                      style: getRegularStyle(color: ColorManager.blackColor),
                    ),
                  ),
                );
              },
            ),
          ),
          MyButton(
            title: 'Confirm',
            onPressed: () async {
              await context.setLocale(Locale(savedLocale!));

              await Restart.restartApp().then((v) {
                context.pop();
              });
            },
          ),
          40.ph
        ]),
      ),
    );
  }
}
