import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_size_model.dart';

class CategoryService {
  Future<Either<String, CategoryItemModel>> categoriesWithItems(
      {required int serviceId}) async {
    try {
      var url = Api.categoriesWithItems + serviceId.toString();

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return right(categoryItemModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}

class ItemVariationService {
  Future<Either<String, ItemVariationSizeModel>> getItemVariationSize(
      {required int itemVariationId}) async {
    try {
      var url = Api.itemVariationSizes + itemVariationId.toString();

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return right(itemVariationSizeModelFromJson(response.body));
      } else {
        return left(response.toString());
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}

class LaundryItemService {
  static Future<dynamic> itemVariations(
      {required int itemId, required int serviceTimingId}) async {
    try {
      var url =
          "${Api.itemVariations}item_id=${itemId}&service_timing_id=${serviceTimingId}";

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
