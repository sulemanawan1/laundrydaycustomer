import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/models/laundry_by_area.model.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/constants/api_routes.dart';

class LaundriesServices {
   Future<Either<String, LaundryByAreaModel>> branchByArea({
    required int serviceId,
    required double userLat,
    required double userLng,
  }) async {
    try {
      Map data = {
        "service_id": serviceId,
        "user_lat": userLat,
        "user_lng": userLng,
      };

      var url = Api.branchByArea;

      var response = await BaseClientClass.post(
        url,
        data,
      );

      if (response is http.Response) {
        return right(laundryByAreaModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      log(e.toString());
      return left('An Error Occured');
    }
  }
}

class DeliveryAgentsAvailibilityService {
  Future<Either<String, Map>> nearByAgents(
      {required double latitude, required double longitude}) async {
    try {
      var url = Api.nearByAgents;

      Map data = {"latitude": latitude, "longitude": longitude};

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        var data = jsonDecode(response.body);

        return right(data);
      } else {
        return left(response);
      }
    } catch (e) {
      print(e.toString());

      return left('An Error Occured');
    }
  }
}
