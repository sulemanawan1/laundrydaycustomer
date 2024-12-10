import 'dart:developer';
import 'package:fpdart/fpdart.dart';

import 'package:http/http.dart' as http;
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/user_subscription_model.dart';
import 'package:laundryday/constants/api_routes.dart';

class UserSubscriptionRepository {
  Future<Either<String, UserSubscriptionModel>> createSubscription(
      {required Map data}) async {
    try {
      var url = Api.createUserSubscriptions;

      var response = await BaseClientClass.postFormReq(url, data);

      if (response is http.Response) {
        return right(userSubscriptionModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e, s) {
      log(s.toString());
      return left('An Error Occured');
    }
  }

  Future<Either<String, UserSubscriptionModel>> cancelSubscription(
      {required int planId}) async {
    try {
      var url = Api.cancelUserSubscription;
      var params = planId.toString();

      var response = await BaseClientClass.get(url, params);

      if (response is http.Response) {
        return right(userSubscriptionModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e, s) {
      log(s.toString());
      return left('An Error Occured');
    }
  }

  Future<Either<String, UserSubscriptionModel>> activeSubscription(
      {required int userId, required String role}) async {
    try {
      var url = Api.activeUserSubscription;
      var param = "${userId.toString()}/$role";
      
      var response = await BaseClientClass.get(url, param);

      if (response is http.Response) {
        return right(userSubscriptionModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e, s) {
      log(s.toString());
      return left('An Error Occured');
    }
  }


  Future<Either<String, UserSubscriptionModel>> updateBranch(
      {required Map data}) async {
    try {
      var url = Api.updateBranch;

      var response = await BaseClientClass.postFormReq(url, data);

      if (response is http.Response) {
        return right(userSubscriptionModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e, s) {
      log(s.toString());
      return left('An Error Occured');
    }
  }

}
