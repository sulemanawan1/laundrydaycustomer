import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/laundries/model/services_timings_model.dart';
import 'package:laundryday/screens/laundries/provider/service_timing_states.dart';
import 'package:laundryday/screens/laundries/service/service_timing_service.dart';

final serviceTimingProvider =
    StateNotifierProvider<ServiceTimingNotifier, ServiceTimingStates>(
        (ref) => ServiceTimingNotifier());

class ServiceTimingNotifier extends StateNotifier<ServiceTimingStates> {
  ServiceTimingNotifier()
      : super(ServiceTimingStates(
            serviceTimingState: ServiceTimingIntitialState())) {}

  Future<dynamic> serviceTimings({
    required int serviceId,
  }) async {
    try {
      state = state.copyWith(serviceTimingState: ServiceTimingLoadingState());
      var data =
          await ServiceTimingService.serviceTimings(serviceId: serviceId);

      if (data is ServiceTimingModel) {
        state = state.copyWith(
            serviceTimingState:
                ServiceTimingLoadedState(serviceTimingModel: data));
      }
    } catch (e) {
      state = state.copyWith(
          serviceTimingState:
              ServiceTimingErrorState(errorMessage: e.toString()));
      throw Exception(e);
    }
  }
}
