import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/models/service_timings_model.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/constants/api_routes.dart';

class ServiceTimingService {
   Future<Either<String, ServiceTimingModel>> serviceTimings(
      {required int serviceId}) async {
    try {
      var url = Api.serviceTimings + serviceId.toString();

      var response = await BaseClientClass.get(url, '');

      if (response is http.Response) {
        return right(serviceTimingModelFromJson(response.body));
      } else {
        return left(response);
      }
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }
}
