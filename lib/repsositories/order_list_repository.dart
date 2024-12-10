import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/models/order_list_model.dart';

class OrderListRepository {
  Future<Either<String, OrderListModel>> customerOrders(
      {required int userId}) async {
    try {
      var url = Api.customerOrders + userId.toString();

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return right(orderListModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      log(e.toString());
      return left('An Error Occured');
    }
  }

  Future<Either<String, OrderListModel>> pendingPickupRequests(
      {required int userId}) async {
    try {
      var url = Api.pendingPickupRequests + userId.toString();

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return right(orderListModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      log(e.toString());
      return left('An Error Occured');
    }
  }
}
