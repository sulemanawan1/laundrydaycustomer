
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/services/resources/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/screens/services/model/customer_order_model.dart';

class CustomerOrderRepository {
  Future<Either<String, CustomerOrderModel>> customerOrders(
      {required int cutstomerId}) async {
    try {
      var url = Api.customerOrders + cutstomerId.toString();

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {

        return right(customerOrderModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      debugPrint(e.toString());
      return left('An Error Occured');
    }
  }
}
