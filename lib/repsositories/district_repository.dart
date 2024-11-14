import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/district_model.dart' as districts;
import 'package:laundryday/resources/api_routes.dart';
import 'package:http/http.dart' as http;

class DistrictRepository {
  Future<Either<String, districts.Datum>> district({required Map data}) async {
    try {
      var url = Api.district;

      var response = await BaseClientClass.postFormReq(url, data);

      if (response is http.Response) {
        return right(
            districts.Datum.fromJson(jsonDecode(response.body)['data']));
      } else {
        return left(response);
      }
    } catch (e, s) {
      log(s.toString());
      return left('An Error Occured');
    }
  }
}
