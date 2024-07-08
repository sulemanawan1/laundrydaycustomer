import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/utils/api_routes.dart';
import 'package:laundryday/utils/base_client_class.dart';
import 'package:http/http.dart' as http;

class MyAdderessesService {
  static Future<dynamic> allAddresses({required int customerId}) async {
    try {
      var url = Api.allAddresses + customerId.toString();

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return myAddressModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }
}
