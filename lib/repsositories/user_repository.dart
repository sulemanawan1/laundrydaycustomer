import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<Either<String, UserModel>> fetchUser({required int userId}) async {
    try {
      var url = "${Api.fetchUser}";
      var params = userId.toString();

      var response = await BaseClientClass.get(url, params);

      if (response is http.Response) {
        return right(userModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }
}
