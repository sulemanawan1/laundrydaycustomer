import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/order_summary_model.dart';
import 'package:http/http.dart' as http;

class OrderSummaryRepository{

  Future<Either<String, OrderSummaryModel>> calculate(
      {required Map data}) async {
    try {
      var url = Api.calculate;

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        return right(orderSummaryModelFromJson(response.body));
      }
      return left(response);
      
    } catch (e, s) {

      log(e.toString());
      log(s.toString());
      return left('An Error Occured');
    }
  }





}