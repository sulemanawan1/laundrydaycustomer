import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';
import 'package:laundryday/screens/auth/signup/provider/signup_states.dart';
import 'package:laundryday/screens/auth/verification/service/verification_service.dart';
import 'package:laundryday/models/user_model.dart' as usermodel;
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/session.dart';
import 'package:laundryday/core/utils.dart';

final signupProvider =
    StateNotifierProvider.autoDispose<SignupNotifier, SignupStates>((ref) {
  final userStates = ref.watch(userProvider);

  return SignupNotifier(userStates: userStates);
});

class SignupNotifier extends StateNotifier<SignupStates> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  UserStates userStates;

  SignupNotifier({required this.userStates})
      : super(SignupStates(isLoading: false));

  void registerUser(
      {required String mobileNumber,
      required String firstName,
      required String lastName,
      required BuildContext context}) async {
    state.isLoading = true;
    state = state.copyWith(isLoading: state.isLoading);

    var data = await VerificationService.registerCustomer(
        mobile_number: mobileNumber, firstName: firstName, lastName: lastName);

    log("Data $data");

    if (data is usermodel.UserModel) {
      
        log(data.token.toString());

        await MySharedPreferences.saveUserSession(user: data);
        userStates.userModel = await MySharedPreferences.getUserSession();

        log("--------- Share Prefrences -----------");
        log(userStates.userModel!.user!.firstName.toString());
        log(userStates.userModel!.user!.lastName.toString());
        log("-----------------------");
        userStates = userStates.copyWith(userModel: userStates.userModel);

        context.pushReplacementNamed(RouteNames.home);
        state.isLoading = false;
        state = state.copyWith(isLoading: state.isLoading);
      
    } else {
      log(data.toString());
      state.isLoading = false;

      Utils.showToast(msg: 'Something Went Wrong');
    }

    state = state.copyWith(isLoading: state.isLoading);
  }
}
