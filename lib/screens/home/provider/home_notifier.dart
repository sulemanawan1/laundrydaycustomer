import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/home/provider/home_states.dart';
import 'package:laundryday/screens/offers/provider/offers_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

final homeProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, HomeStates>(
        (ref) => HomeNotifier());

class HomeNotifier extends StateNotifier<HomeStates> {
  changeIndex({required int index, required WidgetRef ref}) {
    if (state.index != index) {
      log('message $index');

      if (index == 0) {
        ref.refresh(pendingPickupRequestProvider.future);
        ref.refresh(servicesProvider.future);
        ref.refresh(customerOrderProvider.future);
      }

      state = state.copyWith(index: index);
    }
  }

  HomeNotifier()
      : super(HomeStates(
          index: 0,
        )) {}
}
