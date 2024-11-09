import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/susbcription_plan_model.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:http/http.dart' as http;

class SubscriptionPlanRepository {
  Future<Either<String, SubscriptionPlanModel>> subscriptionPlans() async {
    try {
      var url = "${Api.subscriptionPlans}/";
      var params = 'offers';

      var response = await BaseClientClass.get(url, params);

      if (response is http.Response) {
        return right(subscriptionPlanModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }
}
