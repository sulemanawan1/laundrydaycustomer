import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/services/resources/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';

import 'package:http/http.dart' as http;

class DeviceTokenRepository {
  Future<Either<String, bool>> storeFcmToken({
    int? userId,
    String? fcmToken,
    required String deviceId,
  }) async {
    try {
      Map data = {
        "user_id": userId.toString(),
        "fcm_token": fcmToken,
        "device_id": deviceId,
        "app_type": "customer"
      };
      var url = Api.storeFcmToken;

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          bool success = data['success'];

          return right(success);
        } else if (response.statusCode == 403) {
          return left(response.body);
        }
        return left('An error Occured');
      } else {
        return left(response);
      }
    } catch (e) {
      debugPrint(e.toString());
      return left('An Error Occured');
    }
  }
}
