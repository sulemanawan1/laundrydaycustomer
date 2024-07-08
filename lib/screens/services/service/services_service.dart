import 'package:laundryday/screens/services/model/services_model.dart';
import 'package:laundryday/utils/api_routes.dart';
import 'package:laundryday/utils/base_client_class.dart';
import 'package:http/http.dart' as http;

class ServicesService {
  static Future<dynamic> allService() async {
    try {
      var url = Api.allService;

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return serviceModelFromMap(response.body);
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }
}
