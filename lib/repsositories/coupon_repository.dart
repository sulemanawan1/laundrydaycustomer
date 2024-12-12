import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/constants/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/coupon_model.dart';

class CouponRepository {

  Future<Either<String, CouponModel>> validAllcoupons(
      {required Map data}) async {
    try {
      var url = Api.validAllcoupons;

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        return right(couponModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      log(e.toString());
      return left('An Error Occured');
    }
  }


}