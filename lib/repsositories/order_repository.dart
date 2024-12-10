import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderRepository {


  Future<Either<String, OrderModel>> getOrderDetail(
      {required int orderId}) async {
    try {
      var url = Api.order + orderId.toString();

      var response = await BaseClientClass.get(url, '');

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

  Future<Either<String, OrderModel>> pickupOrder(
      {required Map data, required Map files}) async {
    try {
      var url = Api.pickupOrder;

      var response =
          await BaseClientClass.postFormReq2(url, data, files: files);

      if (response is http.Response) {
        log(response.body);
        return right(orderModelFromJson(response.body));
      }
      return left(response);
    } catch (e) {
      debugPrint(e.toString());
      return left('An Error Occured');
    }
  }

  Future<Either<String, OrderModel>> roundTripOrder({required Map data}) async {
    try {
      var url = Api.roundTripOrder;

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        return right(orderModelFromJson(response.body));
      }
      return left(response);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return left('An Error Occured');
    }
  }

  Future<Either<String, OrderModel>> pickupOrderRoundTrip(
      {required Map data}) async {
    try {
      var url = Api.pickupOrderRoundTrip;

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        return right(orderModelFromJson(response.body));
      }
      return left(response);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return left('An Error Occured');
    }
  }

  Future<Either<String, OrderModel>> pickupRequestUpdate(
      {required Map data}) async {
    try {
      var url = Api.pickupRequestUpdate;

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        return right(orderModelFromJson(response.body));
      }
      return left(response);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return left('An Error Occured');
    }
  }

  Future<Either<String, OrderModel>> paymentCollected(
      {required Map data}) async {
    try {
      var url = Api.paymentCollected;

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        return right(orderModelFromJson(response.body));
      }
      return left(response);
    } catch (e) {
      debugPrint(e.toString());
      return left('An Error Occured');
    }
  }
}
