import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:http/http.dart' as http;

class AdderessesService {

   Future<Either<String, MyAddressModel>> allAddresses(
      {required int customerId}) async {
    try {
      var url = Api.allAddresses + customerId.toString();

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return right(myAddressModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      debugPrint(e.toString());
      return left('An Error Occured');
    }
  }

  static Future<dynamic> deleteAddress({required int addressId}) async {
    try {
      var url = Api.deleteAddress + addressId.toString();

      var response = await BaseClientClass.delete(url);

      if (response is http.Response) {
        if (response.statusCode == 200) {
          return true;
        }
      }
    } catch (e) {
      return e;
    }
  }
}
