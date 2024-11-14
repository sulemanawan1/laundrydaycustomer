
import 'package:laundryday/models/susbcription_plan_model.dart' as subscriptionplanmodel;

class OffersStates {
  subscriptionplanmodel.Datum? subscriptionPlanModel;
  OffersStates({
    this.subscriptionPlanModel,
  });

  

  OffersStates copyWith({
    subscriptionplanmodel.Datum? subscriptionPlanModel,
  }) {
    return OffersStates(
      subscriptionPlanModel: subscriptionPlanModel?? this.subscriptionPlanModel,
    );
  }
}
