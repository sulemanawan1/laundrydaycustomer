import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/home/provider/home_states.dart';

final homeProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, HomeStates>(
        (ref) => HomeNotifier());

class HomeNotifier extends StateNotifier<HomeStates> {
  changeIndex({required int index, required WidgetRef ref}) {
    state = state.copyWith(index: index);
  }

  HomeNotifier()
      : super(HomeStates(
         
          index: 0,
        )) {}
}
