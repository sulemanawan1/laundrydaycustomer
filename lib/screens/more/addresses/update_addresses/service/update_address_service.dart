import 'package:laundryday/screens/more/addresses/update_addresses/model/update_address_model.dart';
import 'package:laundryday/config/resources/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:http/http.dart' as http;

class UpdateAddressService {
  static Future<dynamic> updateAddress({
    required int customerId,
    String? file,
        required int addressId,

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
        "id":addressId
      };

      var url = Api.updateAddress;

      var response = await BaseClientClass.postFormReq(url, data,file:  file);

      if (response is http.Response) {
        return updateAddressModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }
}
