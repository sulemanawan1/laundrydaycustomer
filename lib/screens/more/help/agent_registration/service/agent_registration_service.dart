import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:laundryday/core/base_client_class.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/screens/more/help/agent_registration/model/delivery_agent_registartion_model.dart';

class AgentRegistrationService {
  Future<Either<String, DeliveryAgentModel>> registerDeliveryAgent({
    required Map data,
    Map? files,
  }) async {
    try {
      var url = Api.registerDeliveryAgents;

      var response =
          await BaseClientClass.postFormReq2(url, data, files: files);

      if (response is http.Response) {
        if (response.statusCode == 201) {
          return right(deliveryAgentModelFromJson(response.body));
        } else if (response.statusCode == 400) {
          return left(response.body.toString());
        }
      }
      return left(response);
    } catch (e, s) {
      log(s.toString());
      return left("An Error Occured");
    }
  }
}
