import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/constants/api_routes.dart';
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



  Future<Either<String, UserModel>> getUserProfile({
    required int userId,
  }) async {
    try {
      var url = Api.fetchUser;

      var param = userId.toString();

      var response = await BaseClientClass.get(url, param);

      if (response is http.Response) {
        return right(userModelFromJson(response.body));
      }
      return left(response);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, UserModel>> updateUser({
    required Map data,
    Map? files,
  }) async {
    try {
      var url = Api.updateUser;

      var response =
          await BaseClientClass.postFormReq2(url, data, files: files);

      if (response is http.Response) {
        return right(userModelFromJson(response.body));
      }
      return left(response);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, UserModel>> updateUserMobileNumber({
    required Map data,
  }) async {
    try {
      var url = Api.updateUserMobileNumber;

      var response = await BaseClientClass.postFormReq2(
        url,
        data,
      );

      if (response is http.Response) {
        if (response.statusCode == 200) {
          return right(userModelFromJson(response.body));
        }
      }
      return left(response);
    } catch (e, s) {
      log(s.toString());
      return left(e.toString());
    }
  }

}
