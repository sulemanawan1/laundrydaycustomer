import 'package:http/http.dart' as http;
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/model/laundry_model.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/services/resources/api_routes.dart';

class LaundryItemService{


   static Future<dynamic> nearestBranch({
    required int serviceId,
    required double userLat,
    required double radius,
    required double userLng,
  }) async {
    try {
      Map data = {
        "service_id": serviceId,
        "user_lat": userLat,
        "user_lng": userLng,
        "radius": radius
      };

      var url = Api.nearstBranch;

      var response = await BaseClientClass.postFormReq(url, data);

      if (response is http.Response) {
        if (response.statusCode == 200) {
          return nearestLaundryModelFromJson(response.body);
        }
      }
    } catch (e) {
      return e;
    }
  }


   static Future<dynamic> categoriesWithItems({required int serviceId}) async {
    try {
      var url = Api.categoriesWithItems+serviceId.toString();

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return categoryItemModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }


   static Future<dynamic> itemVariations({required int itemId,
    required int serviceTimingId}) async {
    try {
      var url = "${Api.itemVariations}item_id=${itemId}&service_timing_id=${serviceTimingId}";

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return itemVariationModelFromJson(response.body);
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }


}