import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/screens/services/model/services_model.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:http/http.dart' as http;

class ServicesService {


  Future<Either<String, ServiceModel>> allService(
     ) async {
    try {
      var url = Api.allService;

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return right(serviceModelFromMap(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      debugPrint(e.toString());
      return left('An Error Occured');
    }
  }
}
