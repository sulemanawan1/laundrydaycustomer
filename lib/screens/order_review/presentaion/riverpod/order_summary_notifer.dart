import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/models/order_summary_model.dart';
import 'package:laundryday/repsositories/order_summary_repository.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/order_summary_states.dart';
import 'package:laundryday/shared/app_state.dart';

final orderSummaryRepoProvider = Provider((ref) {
  return OrderSummaryRepository();
});

final orderSummaryProvider =
    StateNotifierProvider.autoDispose<OrderSummaryNotifer, OrderSummaryStates>(
        (ref) {
  return OrderSummaryNotifer();
});

class OrderSummaryNotifer extends StateNotifier<OrderSummaryStates> {
  OrderSummaryNotifer()
      : super(OrderSummaryStates(appState: AppInitialState()));

 Future calulate({required WidgetRef ref, required Map data}) async {
    try {
      state = state.copyWith(appState: AppLoadingState());

      Either<String, OrderSummaryModel> apiData =
          await ref.read(orderSummaryRepoProvider).calculate(data: data);

      apiData.fold((l) {
        state = state.copyWith(appState: AppErrorState(error: l));
      }, (data) {
        state = state.copyWith(
            appState: AppLoadedState(data: data));
      });
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());

      state =
          state.copyWith(appState: AppErrorState(error: 'An Error Occured'));
    }
  }
}
