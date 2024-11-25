import 'package:flutter/material.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/country_model.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:http/http.dart' as http;
class CountryRepository{


   static Future<dynamic> countries() async {
    try {
      var url = Api.countries;

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return countryModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }
}