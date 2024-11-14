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

final subscriptionPlanRepoProvider = Provider.autoDispose((ref) {
  return SubscriptionPlanRepository();
});

final subscriptionPlanProvider =
    FutureProvider.autoDispose<Either<String, SubscriptionPlanModel>>((ref) {
  return ref.read(subscriptionPlanRepoProvider).subscriptionPlans();
});

final userRepoProvider = Provider.autoDispose((ref) => UserRepository());

final fetchUserProvider =
    FutureProvider.autoDispose<Either<String, UserModel>>((ref) {
  final userId = ref.read(userProvider).userModel!.user!.id;
  return ref.read(userRepoProvider).fetchUser(userId: userId!);
});

final activeUserSubscriptionProvider =
    FutureProvider.autoDispose<Either<String, UserSubscriptionModel>>((ref) {
  final userId =
      ref.read(userProvider).userModel!.user!.id;
  return ref
      .read(userSubscriptionRepoProvider)
      .activeSubscription(userId: userId!);
});

final offerProvider = StateNotifierProvider< OffersNotifier,OffersStates>((ref) => OffersNotifier());

class OffersNotifier extends StateNotifier<OffersStates> {
  OffersNotifier() : super(OffersStates());

  selectSubscription(
      {required subscriptionplanmodel.Datum selectedSubscription}) {
    state = state.copyWith(subscriptionPlanModel: selectedSubscription);
  }
}
