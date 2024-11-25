import 'package:flutter/material.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/city_model.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:http/http.dart' as http;

class CityRepository{


  static Future<dynamic> cities({required int regionId}) async {
    try {
      var url = "${Api.cities}/$regionId";

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return cityModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }
}