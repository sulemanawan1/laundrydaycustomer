import 'package:laundryday/shared/app_state.dart';

class OrderSummaryStates {
  AppState appState;
  OrderSummaryStates({
    required this.appState,
  });

  

  OrderSummaryStates copyWith({
    AppState? appState,
  }) {
    return OrderSummaryStates(
      appState: appState ?? this.appState,
    );
  }
}
