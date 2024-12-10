import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/screens/auth/login/provider/login_notifier.dart';
import 'package:laundryday/screens/home/provider/home_notifier.dart';
import 'package:laundryday/screens/more/profile/provider/change_mobile_number_verification_states.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;
import 'package:laundryday/screens/more/profile/provider/profile_notifier.dart';

final changeMobileNumberVerificationProvider =
    StateNotifierProvider.autoDispose<ChangeMobileNumberVerificationNotifier,
        ChangeMobileNumberVerificationStates>((ref) {
  return ChangeMobileNumberVerificationNotifier();
});

class ChangeMobileNumberVerificationNotifier
    extends StateNotifier<ChangeMobileNumberVerificationStates> {
  ChangeMobileNumberVerificationNotifier()
      : super(ChangeMobileNumberVerificationStates(isLoading: false));
  TextEditingController codeController = TextEditingController();

  void signInWithPhoneNumber(
      {required String SmsCode,
      required BuildContext context,
      required WidgetRef ref,
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
        log(user.uid);
        log(user.phoneNumber.toString());

        final userId = ref.read(userProvider).userModel!.user!.id;
        Map data = {
          "mobile_number": user.phoneNumber.toString(),
          "user_id": userId,
          "role": "customer"
        };
        updateUserMobileNumber(context: context, data: data, ref: ref);
      } else {
        Utils.showToast(msg: 'Something Went Wrong');
      }

      state = state.copyWith(isLoading: false);

      // Handle signed in user
    } catch (e, s) {
      print('Error: $s');

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

  updateUserMobileNumber(
      {required Map data,
      required WidgetRef ref,
      required BuildContext context}) async {
    Either<String, UserModel> apiData =
        await ref.read(getUserProfileApi).updateUserMobileNumber(data: data);

    apiData.fold((l) {
      if (l.toLowerCase() == 'conflict') {
        BotToast.showNotification(
          leading: (cancelFunc) => Icon(
            Icons.info,
            color: ColorManager.whiteColor,
          ),
          backgroundColor: Colors.red,
          title: (title) {
            return Text(
              "Mobile Number Already Taken",
              style:
                  getRegularStyle(color: ColorManager.whiteColor, fontSize: 14),
            );
          },
        );
      } else {
        BotToast.showNotification(
          leading: (cancelFunc) => Icon(
            Icons.info,
            color: ColorManager.whiteColor,
          ),
          backgroundColor: Colors.red,
          title: (title) {
            return Text(
              l.toString(),
              style:
                  getRegularStyle(color: ColorManager.whiteColor, fontSize: 14),
            );
          },
        );
      }
    }, (r) {
      ref.read(homeProvider.notifier).changeIndex(index: 0, ref: ref);

      Utils.showToast(msg: 'Mobile Number Updated Successfully');
      context.goNamed(RouteNames.home);
    });
  }
}
