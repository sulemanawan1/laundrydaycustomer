import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/token_model.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:http/http.dart' as http;

class OrderChatService {
  Future<Either<String, TokenModel>> fcmTokens({required int userId}) async {
    try {
      var url = Api.fcmTokens;

      Map data = {"user_id": userId, "app_type": 'delivery'};

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        return right(tokenModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      debugPrint(e.toString());
      return left('An Error Occured');
    }
  }
}
