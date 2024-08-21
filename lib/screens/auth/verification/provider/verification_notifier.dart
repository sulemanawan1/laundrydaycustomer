import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/models/my_user_model.dart' as usermodel;
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/provider/user_states.dart';
import 'package:laundryday/screens/auth/login/provider/login_notifier.dart';
import 'package:laundryday/screens/auth/verification/provider/verification_states.dart';
import 'package:laundryday/screens/auth/verification/service/verification_service.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/session.dart';
import 'package:laundryday/core/utils.dart';

final verificationProvider =
    StateNotifierProvider.autoDispose<VerificationNotifier, VerificationStates>(
        (ref) {
  final userStates = ref.watch(userProvider);

  return VerificationNotifier(userStates: userStates);
});

class VerificationNotifier extends StateNotifier<VerificationStates> {
  UserStates userStates;

  VerificationNotifier({required this.userStates})
      : super(VerificationStates(isLoading: false));
  TextEditingController codeController = TextEditingController();

  Future<dynamic> checkUserByMobileNumber({
    required String mobile_number,
  }) async {
    var data = await VerificationService.checkUserByMobileNumber(
        mobile_number: mobile_number);

    if (data is usermodel.UserModel) {
      // await MySharedPreferences.saveUserSession(user: data);

      // userStates.userModel = await MySharedPreferences.getUserSession();

      // userStates = userStates.copyWith(userModel: userStates.userModel);

      // state = state.copyWith(userModel: userStates.userModel);
      return data;
    }
    return data;
  }

  void signInWithPhoneNumber(
      {required String SmsCode,
      required BuildContext context,
      required String verificationId}) async {
    state = state.copyWith(isLoading: true);

    try {
      final credential = await firebaseauth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: SmsCode,
      );
      final firebaseauth.User? user =
          (await auth.signInWithCredential(credential)).user;

      if (user != null) {
        dynamic data =
            await checkUserByMobileNumber(mobile_number: user.phoneNumber!);
        log("Firebase Phone Number");
        log("-------------------------");
        log(user.phoneNumber.toString());
        log("--------------------------");

        if (data is usermodel.UserModel) {
          if (data.succcess == true) {
            log(data.token.toString());

            await MySharedPreferences.saveUserSession(user: data);
            userStates.userModel = await MySharedPreferences.getUserSession();

            log("--------- Share Prefrences -----------");
            log(userStates.userModel!.user!.firstName.toString());
            log(userStates.userModel!.user!.lastName.toString());
            log("-----------------------");
            userStates = userStates.copyWith(userModel: userStates.userModel);

            // state = state.copyWith(userModel: userStates.userModel);

            context.pushReplacementNamed(RouteNames.home);
          } else {
            log('Use does not exist');
            context.pushReplacementNamed(RouteNames.signUp,
                extra: user.phoneNumber);
          }
        } else {
          Utils.showToast(msg: 'Something Went Wrong');
        }
      }

      state = state.copyWith(isLoading: false);

      // Handle signed in user
    } catch (e) {
      print('Error: $e');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Operation Failed"),
            content: Text("$e"),
            actions: <Widget>[
              OutlinedButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      state = state.copyWith(isLoading: false);
    }
  }
}
