import 'package:http/http.dart' as http;
import 'package:laundryday/screens/laundries/model/services_timings_model.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/services/resources/api_routes.dart';

class ServiceTimingService {
  static Future<dynamic> serviceTimings({required int serviceId}) async {
    try {
      var url = Api.serviceTimings + serviceId.toString();

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return serviceTimingModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }
}
