import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/models/user_subscription_model.dart';
import 'package:laundryday/repsositories/user_subscription_repository.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/screens/offers/provider/offers_notifier.dart';
import 'package:laundryday/screens/subscription/provider/subscription_states.dart';

final userSubscriptionRepoProvider = Provider.autoDispose((ref) {
  return UserSubscriptionRepository();
});

final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, SubscriptionStates>(
        (ref) => SubscriptionNotifier());

class SubscriptionNotifier extends StateNotifier<SubscriptionStates> {
  SubscriptionNotifier() : super(SubscriptionStates());

  createSubscription(
      {required Map data,
      required BuildContext context,
      required WidgetRef ref}) async {
    BotToast.showLoading();

    Either<String, UserSubscriptionModel> apiData = await ref
        .read(userSubscriptionRepoProvider)
        .createSubscription(data: data);

    apiData.fold((l) {
      log(l);

      BotToast.closeAllLoading();
      BotToast.showNotification(
          title: (title) => Text(
                l,
                style: getRegularStyle(color: ColorManager.whiteColor),
              ),
          backgroundColor: ColorManager.redColor);
    }, (r) {
      debugPrint(r.message);

      context.pop();
      context.pop();

      ref.refresh(fetchUserProvider);
      ref.refresh(activeUserSubscriptionProvider);

      // ref.refresh(activeUserSubscriptionProvider);

      // context.pushReplacementNamed(RouteNames().yourArea);

      Future.delayed(Duration(seconds: 3), () {
        BotToast.closeAllLoading();
      });
    });
  }
}
