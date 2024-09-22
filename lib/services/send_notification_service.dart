import 'dart:convert';
import 'dart:developer';
import 'get_server_key.dart';
import 'package:http/http.dart' as http;

class SendNotificationService {
  static Future<void> sendNotificationUsingApi({
    required String? token,
    required String? title,
    required String? body,
    required String? type,
    required Map<String, dynamic>? data,
  }) async {
    log(data.toString());
    String serverKey = await GetServerKey.getServerKeyToken();
    print("notification server key => ${serverKey}");
    String url =
        "https://fcm.googleapis.com/v1/projects/laundryday-ef178/messages:send";

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    //mesaage
    Map<String, dynamic> message = {
      "message": {
        "token": token,
        "notification": {
          "body": body,
          "title": title,
        },
        "android": {
          "priority": "high",
          "notification": {
            "click_action": "OPEN_ACTIVITY_1",
            "color": "#f45342",
            "sound": "default"
          }
        },
        "apns": {
          "headers": {"apns-priority": "10"}
        },
        "data": {
          "type": type,
        }
      }
    };

    //hit api
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(message),
    );

    log(response.body);
    if (response.statusCode == 200) {
      print("Notification Send Successfully!");
    } else {
      print("Notification not send!");
    }
  }
}
