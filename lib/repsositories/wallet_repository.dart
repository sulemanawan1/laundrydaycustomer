import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/constants/api_routes.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/models/wallet_model.dart';

class WalletRepository {
  Future<Either<String, WalletModel>> walletBalance(
      {required int userId}) async {
    try {
      var url = Api.walletBalance;
      var params = "${userId}/balance";

      var response = await BaseClientClass.get(url, params);

      if (response is http.Response) {
        return right(walletModelFromJson(response.body));
      }
      return left(response);
    } catch (e) {
      return left(e.toString());
    }
  }
}
