import 'package:http/http.dart' as http;
import 'package:laundryday/models/city_model.dart';
import 'package:laundryday/models/country_model.dart';
import 'package:laundryday/models/district_model.dart';
import 'package:laundryday/models/region_model.dart';
import 'package:laundryday/screens/add_laundry/data/models/add_laundry_model.dart';
import 'package:laundryday/config/resources/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';

class AddLaundryRepository {
  static Future<dynamic> countries() async {
    try {
      var url = Api.countries;

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return countryModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<dynamic> regions({required int countryId}) async {
    try {
      var url = "${Api.regions}/$countryId";

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return regionModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<dynamic> cities({required int regionId}) async {
    try {
      var url = "${Api.cities}/$regionId";

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return cityModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<dynamic> districts({required int cityId}) async {
    try {
      var url = "${Api.districts}/$cityId";

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return districtModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future<dynamic> registerLaundry({required Map laundrydata}) async {
    try {
      Map data = laundrydata;

      var url = Api.registerLaundry;

      var response = await BaseClientClass.post(
        url,
        data,
      );

      if (response is http.Response) {
        return addLaundryModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }
}
