import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
import 'package:laundryday/screens/auth/login/login.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/utils.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:pinput/pinput.dart';

class Verification extends StatelessWidget {
  final String verificationId;
  Verification({super.key, required this.verificationId});
  TextEditingController _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                  child: Column(children: [
                    20.ph,
                    Icon(
                      Icons.lock_outlined,
                      size: 80,
                      color: ColorManager.primaryColor,
                    ),
                    10.ph,
                    const Heading(text: 'Verification'),
                    10.ph,
                    HeadingMedium(
                        title: "Enter your 4 digits\nVerification Code."),
                    10.ph,
                    SizedBox(
                      width: double.infinity,
                      child: Pinput(
                        controller: _codeController,
                        defaultPinTheme: PinTheme(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromRGBO(241, 240, 245, 1))),
                        errorTextStyle: GoogleFonts.poppins(color: Colors.red),
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        validator: ValidationHelper().otpValidator,
                        length: 6,
                        onCompleted: (val) {
                          _signInWithPhoneNumber(SmsCode: val);
                        },
                      ),
                    ),
                    20.ph,
                  ]),
                ),
              ),
              20.ph,
              MyButton(
                // loading: verificationCodeController.isLoading.value,
                name: 'Verify',
                onPressed: () {
                  // _signInWithPhoneNumber();
                  // GoRouter.of(context).pushNamed(RouteNames().signUp);
                },
              ),
              12.ph,
              Wrap(
                children: [
                  HeadingMedium(title: "Didn't receive a verification code?"),
                  5.pw,
                  GestureDetector(
                    onTap: () {
                      Utils.showToast(msg: 'Code Sent');
                      // GoRouter.of(context).pushNamed(RouteNames().mobileNumber);
                    },
                    child: Text(
                      "Resend",
                      style: GoogleFonts.poppins(
                          color: ColorManager.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              40.ph
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithPhoneNumber({required String SmsCode}) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: SmsCode,
    );

    User? user = (await auth.signInWithCredential(credential)).user;

    if (user != null) {
      // Handle successful login
      print("Successfully signed in UID: ${user.uid}");
    } else {
      // Handle error
      print("Failed to sign in");
    }
  }
}
