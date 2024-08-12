import 'package:http/http.dart' as http;
import 'package:laundryday/screens/laundries/model/laundry_by_area.model.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/config/resources/api_routes.dart';

class LaundriesServices {

  static Future<dynamic> branchByArea({
    required int serviceId,
    required String district,

    required double userLat,
    required double userLng,
  }) async {
    try {
      Map data = {
        "service_id": serviceId,
        "user_lat": userLat,
        "user_lng": userLng,
        "district": district
      };

      var url = Api.branchByArea;

      var response = await BaseClientClass.post(
        url,
        data,
      );

      if (response is http.Response) {
        return laundryByAreaModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }
}
