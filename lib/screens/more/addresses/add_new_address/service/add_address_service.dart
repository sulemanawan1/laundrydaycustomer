import 'package:laundryday/screens/more/addresses/add_new_address/model/add_address_model.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:http/http.dart' as http;

class AddAddressService {
  static Future<dynamic> addAddress({
    required int user_id,
    String? file,
    required String district,
    required String country,
    required String city,
    required String googleAddress,
    required String addressDetail,
    required double lat,
    required double lng,
  }) async {
    try {
      Map data = {
        "user_id": user_id,
        "google_map_address": googleAddress,
        "address_detail": addressDetail,
        "lat": lat,
        "lng": lng,
        "district": district,
        "country": country,
        "city": city
      };

      var url = Api.addAddress;

      var response = await BaseClientClass.postFormReq(url, data, file: file);

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
