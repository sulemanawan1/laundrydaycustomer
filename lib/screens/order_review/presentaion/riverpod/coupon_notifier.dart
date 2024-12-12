import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/models/coupon_model.dart';
import 'package:laundryday/repsositories/coupon_repository.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/coupon_states.dart';
import 'package:laundryday/shared/app_state.dart';

final couponRepoProvider = Provider((ref) {
  return CouponRepository();
});

final couponProvider =
    StateNotifierProvider.autoDispose<CouponNotifier, CouponStates>((ref) {
  return CouponNotifier();
});

class CouponNotifier extends StateNotifier<CouponStates> {
  CouponNotifier() : super(CouponStates(appState: AppInitialState()));

Future  validAllcoupons({required WidgetRef ref, required Map data}) async {
    try {
      state = state.copyWith(appState: AppLoadingState());

      Either<String, CouponModel> apiData =
          await ref.read(couponRepoProvider).validAllcoupons(data: data);

      apiData.fold((l) {
        state = state.copyWith(appState: AppErrorState(error: l));
      }, (data) {
        state = state.copyWith(appState: AppLoadedState(data: data));
      });
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());

      state =
          state.copyWith(appState: AppErrorState(error: 'An Error Occured'));
    }
  }

  selectedCoupon({required Coupon coupon}) {
    state = state.copyWith(selectedCoupon: coupon);
  }
}
