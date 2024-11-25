import 'package:flutter/material.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/region_model.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:http/http.dart' as http;

class RegionRepository{


  static Future<dynamic> regions() async {
    try {
      var url = "${Api.regions}";

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return regionModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }
  
}