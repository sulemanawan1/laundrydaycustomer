import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/home/provider/home_states.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

final homeProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, HomeStates>(
        (ref) => HomeNotifier());

class HomeNotifier extends StateNotifier<HomeStates> {
  changeIndex({required int index, required WidgetRef ref}) {
    state = state.copyWith(index: index);

    if (index == 0) {
      ref.invalidate(serviceProvider);
    }
  }

  HomeNotifier()
      : super(HomeStates(
            onGoingOrderTimerList: [],
            index: 0,
           )) {}
}
