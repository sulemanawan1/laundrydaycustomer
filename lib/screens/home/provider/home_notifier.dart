import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/home/provider/home_states.dart';
import 'package:laundryday/screens/offers/provider/offers_notifier.dart';

final homeProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, HomeStates>(
        (ref) => HomeNotifier());

class HomeNotifier extends StateNotifier<HomeStates> {
  changeIndex({required int index, required WidgetRef ref}) {
    log(index.toString());

    if (index == 2) {
      ref.invalidate(fetchUserProvider);
      ref.invalidate(activeUserSubscriptionProvider);
    }
    state = state.copyWith(index: index);
  }

  HomeNotifier()
      : super(HomeStates(
          index: 0,
        )) {}
}
