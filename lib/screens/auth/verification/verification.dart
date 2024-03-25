import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
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
  const Verification({super.key});

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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
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
                    const HeadingSmall(
                        title: "Enter your 4 digits\nVerification Code."),
                    10.ph,
                    SizedBox(
                      width: double.infinity,
                      child: Pinput(
                        
                        
                        defaultPinTheme: PinTheme(width: 70.0,
                        height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromRGBO(241, 240, 245, 1))),
                        
                        errorTextStyle:
                        
                            GoogleFonts.poppins(color: Colors.red),
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        validator: ValidationHelper().otpValidator,
                        length: 4,
                        onCompleted: (val) {},
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
                  GoRouter.of(context).pushNamed(RouteNames().signUp);
                },
              ),
              12.ph,
              Wrap(
                children: [
                  const HeadingSmall(
                      title: "Didn't receive a verification code?"),
                  5.pw,
                  GestureDetector(
                    onTap: () {
                      Utils.showToast(msg: 'Code Sent');
                      // GoRouter.of(context).pushNamed(RouteNames().mobileNumber);
                    },
                    child: Text(
                      "Resend",
                      style: GoogleFonts.poppins(
                          color: ColorManager.primaryColor, fontWeight: FontWeight.bold),
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
}
