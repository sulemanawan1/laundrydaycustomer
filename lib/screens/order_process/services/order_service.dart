import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/config/resources/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart';
import 'package:http/http.dart' as http;
class OrderService {





  Future<Either<String, OrderModel>> getOrderDetail(
      {required int orderId}) async {
    try {
      var url = Api.order+orderId.toString();

      var response =
          await BaseClientClass.get(url,'');

      if (response is http.Response) {
        return right(orderModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      debugPrint(e.toString());
      return left('An Error Occured');
    }
  }




}