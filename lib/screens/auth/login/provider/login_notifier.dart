import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/screens/auth/login/provider/login_states.dart';
import 'package:laundryday/config/routes/route_names.dart';

final loginProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginStates>(
        (ref) => LoginNotifier());
final FirebaseAuth auth = FirebaseAuth.instance;

class LoginNotifier extends StateNotifier<LoginStates> {
  LoginNotifier() : super(LoginStates(isLoading: false));

  final TextEditingController phoneController = TextEditingController();

  void verifyPhoneNumber(
      {required BuildContext context,
      }) async {
    state = state.copyWith(isLoading: true);

    await auth.verifyPhoneNumber(
      phoneNumber: "+966${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        log("----Code------");
        log("----Code------");


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

          context.pushReplacementNamed(RouteNames.verification,
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
