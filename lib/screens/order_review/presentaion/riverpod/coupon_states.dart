import 'package:laundryday/models/coupon_model.dart';
import 'package:laundryday/shared/app_state.dart';

class CouponStates {
  AppState appState;
  Coupon? selectedCoupon;
  CouponStates({
    this.selectedCoupon,
    required this.appState,
  });

  CouponStates copyWith({
    AppState? appState,
      Coupon? selectedCoupon


  }) {
    return CouponStates(
      selectedCoupon: selectedCoupon??this.selectedCoupon,
      appState: appState ?? this.appState,
    );
  }
}
