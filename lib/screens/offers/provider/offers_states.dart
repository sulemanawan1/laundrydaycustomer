import 'package:laundryday/models/susbcription_plan_model.dart'
    as subscriptionplanmodel;
import 'package:laundryday/models/user_subscription_model.dart' as usersubscriptionmodel;

class OffersStates {
  subscriptionplanmodel.Datum? subscriptionPlanModel;

  usersubscriptionmodel.Data? userSubscriptionModel;
  OffersStates({
    this.subscriptionPlanModel,
    this.userSubscriptionModel
  });

  OffersStates copyWith({
      usersubscriptionmodel.Data? userSubscriptionModel,

    subscriptionplanmodel.Datum? subscriptionPlanModel,
  }) {
    return OffersStates(
      userSubscriptionModel:userSubscriptionModel??this.userSubscriptionModel,
      subscriptionPlanModel:
          subscriptionPlanModel ?? this.subscriptionPlanModel,
    );
  }


}
