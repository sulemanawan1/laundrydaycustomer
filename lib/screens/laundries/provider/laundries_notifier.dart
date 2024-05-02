import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/laundries/model/services_timings_model.dart';
import 'package:laundryday/screens/laundries/provider/laundries_states.dart';

final laundriessProvider =
    StateNotifierProvider.autoDispose<LaundriesNotifier, LaundriesStates>(
        (ref) => LaundriesNotifier());

class LaundriesNotifier extends StateNotifier<LaundriesStates> {
  LaundriesNotifier()
      : super(LaundriesStates(index: 0, serviceTypesList: [
          ServicesTimingModel(
              duration: 1,
              type: 'day',
              description: '24-hours Service',
              id: 1,
              name: 'Normal',
              img: 'assets/icons/24-hour-service.png'),
          ServicesTimingModel(
              duration: 1,
              type: 'hour',
              description: '1 hour Service',
              id: 2,
              name: 'Quick',
              img: 'assets/icons/rush.png'),
        ]));

  selectServiceTime({required int index}) {
    state = state.copyWith(index: index);
  }
}
