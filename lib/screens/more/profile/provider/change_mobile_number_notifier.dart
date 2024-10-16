import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/screens/more/profile/provider/change_mobile_number_states.dart';

final changeMobileNumberProvider = StateNotifierProvider.autoDispose<
    ChangeMobileNumberNotifier,
    ChangeMobileNumberStates>((ref) => ChangeMobileNumberNotifier());

class ChangeMobileNumberNotifier
    extends StateNotifier<ChangeMobileNumberStates> {
  ChangeMobileNumberNotifier()
      : super(ChangeMobileNumberStates(isLoading: false));

  final TextEditingController mobileNumber = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void verifyPhoneNumber({
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);

    await _auth.verifyPhoneNumber(
      phoneNumber: "+966${mobileNumber.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        log("----Code------");
        log("----Code------");

        // await auth.signInWithCredential(credential);

        state = state.copyWith(isLoading: false);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.code);

        if (mounted) {
          state = state.copyWith(isLoading: false);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Operation Failed"),
                content: Text(e.code.toString()),
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
          print(e.message);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        if (mounted) {
          state =
              state.copyWith(verificationId: verificationId, isLoading: false);

          context.pushNamed(RouteNames.changeMobileNumberVerification,
              extra: state.verificationId);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (mounted) {
          state =
              state.copyWith(verificationId: verificationId, isLoading: false);
        }
      },
    );
  }
}
