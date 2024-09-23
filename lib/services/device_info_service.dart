import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  DeviceInfoService._();

  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfos = await deviceInfo.iosInfo;

      return iosInfos.identifierForVendor ?? "unknown";
    } else {
      return 'unknown';
    }
  }
}
