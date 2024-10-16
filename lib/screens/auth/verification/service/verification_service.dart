import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:http/http.dart' as http;

class VerificationService {
  static Future<dynamic> checkUserByMobileNumber(
      {required String mobile_number}) async {
    try {
      Map data = {"mobile_number": mobile_number, "role": "customer"};
      var url = Api.checkUserByMobileNumber;

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        return userModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> registerCustomer(
      {required String mobile_number,
      required String firstName,
      required String lastName}) async {
    try {
      Map data = {
        "mobile_number": mobile_number,
        "first_name": firstName,
        "last_name": lastName,
        "role": 'customer',
      };
      var url = Api.registerUser;

      var response = await BaseClientClass.post(url, data);

      if (response is http.Response) {
        return userModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }
}
