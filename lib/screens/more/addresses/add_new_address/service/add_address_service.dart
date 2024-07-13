import 'dart:io';

import 'package:laundryday/screens/more/addresses/add_new_address/model/add_address_model.dart';
import 'package:laundryday/utils/constants/api_routes.dart';
import 'package:laundryday/utils/base_client_class.dart';
import 'package:http/http.dart' as http;

class AddAddressService {
  static Future<dynamic> addAddress({
    required int customerId,
    String? file,
    required String googleAddress,
    required String addressName,
    required String addressDetail,
    required double lat,
    required double lng,
  }) async {
    try {
      Map data = {
        "customer_id": customerId,
        "google_map_address": googleAddress,
        "address_name": addressName,
        "address_detail": addressDetail,
        "lat": lat,
        "lng": lng,
      };

      var url = Api.addAddress;

      var response = await BaseClientClass.postFormReq(url, data, file);

      if (response is http.Response) {
        return addAddressModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }
}
