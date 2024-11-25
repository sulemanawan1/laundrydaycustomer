import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/models/susbcription_plan_model.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/models/user_subscription_model.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/repsositories/subscription_plan_repository.dart';
import 'package:laundryday/repsositories/user_repository.dart';
import 'package:laundryday/screens/offers/provider/offers_states.dart';
import 'package:laundryday/models/susbcription_plan_model.dart'
    as subscriptionplanmodel;
import 'package:laundryday/screens/subscription/provider/subscription_notifier.dart';
import 'package:laundryday/models/user_subscription_model.dart'
    as usersubscriptionmodel;

final subscriptionPlanRepoProvider = Provider((ref) {
  return SubscriptionPlanRepository();
});

final subscriptionPlanProvider =
    FutureProvider<Either<String, SubscriptionPlanModel>>((ref) {
  return ref.read(subscriptionPlanRepoProvider).subscriptionPlans();
});

final userRepoProvider = Provider((ref) => UserRepository());

final fetchUserProvider =
    FutureProvider<Either<String, UserModel>>((ref) {
  final userId = ref.read(userProvider).userModel!.user!.id;
  return ref.read(userRepoProvider).fetchUser(userId: userId!);
});

final activeUserSubscriptionProvider =
    FutureProvider<Either<String, UserSubscriptionModel>>((ref) {
  final userId = ref.read(userProvider).userModel!.user!.id;
  return ref
      .read(userSubscriptionRepoProvider)
      .activeSubscription(userId: userId!);
});

final offerProvider = StateNotifierProvider<OffersNotifier, OffersStates>(
    (ref) => OffersNotifier());

class OffersNotifier extends StateNotifier<OffersStates> {
  OffersNotifier() : super(OffersStates());

  selectSubscription(
      {required subscriptionplanmodel.Datum selectedSubscription}) {
    state = state.copyWith(subscriptionPlanModel: selectedSubscription);
  }

  selectUserSubscription(
      {required usersubscriptionmodel.Data userSubscriptionModel}) {
    state = state.copyWith(userSubscriptionModel: userSubscriptionModel);
  }
}
