import 'package:laundryday/screens/laundries/model/services_timings_model.dart';

class ServiceTimingStates {
  ServiceTimingState serviceTimingState;
  ServiceTimingStates({
    required this.serviceTimingState,
  });

  ServiceTimingStates copyWith({
    ServiceTimingState? serviceTimingState,
  }) {
    return ServiceTimingStates(
      serviceTimingState: serviceTimingState ?? this.serviceTimingState,
    );
  }
}

abstract class ServiceTimingState {}

class ServiceTimingIntitialState extends ServiceTimingState {}

class ServiceTimingLoadingState extends ServiceTimingState {}

class ServiceTimingLoadedState extends ServiceTimingState {
  ServiceTimingModel serviceTimingModel;
  ServiceTimingLoadedState({required this.serviceTimingModel});
}

class ServiceTimingErrorState extends ServiceTimingState {
  String errorMessage;
  ServiceTimingErrorState({required this.errorMessage});
}
