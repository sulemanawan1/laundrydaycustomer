import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';
import 'package:laundryday/shared/provider/user_states.dart';
import 'package:laundryday/screens/splash/provider/splash_states.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/session.dart';

final splashProvider =
    StateNotifierProvider<SplashNotifier, SplashStates>((ref) {
  final userStates = ref.watch(userProvider);

  return SplashNotifier(userStates: userStates);
});

class SplashNotifier extends StateNotifier<SplashStates> {
  UserStates userStates;
  SplashNotifier({required this.userStates})
      : super(SplashStates(userModel: null));

  checkSession({required BuildContext context}) async {
    userStates.userModel = await MySharedPreferences.getUserSession();

    userStates = userStates.copyWith(userModel: userStates.userModel);

    print("-----------------------------");
    print(userStates.userModel!.user!.id);
    print("-----------------------------");
    state = state.copyWith(userModel: userStates.userModel);

    Future.delayed(const Duration(seconds: 2), () {
      if (state.userModel!.token != null) {
        context.goNamed(RouteNames.home);
      } else {
        context.goNamed(
          RouteNames.login,
        );
      }
    });
  }
}
