import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/auth/verification/provider/verification_notifier.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:pinput/pinput.dart';

class Verification extends ConsumerWidget {
  final String verificationId;
  Verification({super.key, required this.verificationId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(verificationProvider.notifier);
    final isLoading = ref.watch(verificationProvider).isLoading;
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
                    Text(
                      'Verification',
                      style: getSemiBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s14),
                    ),
                    10.ph,
                    HeadingMedium(
                        title: "Enter your 6 digits\nVerification Code."),
                    10.ph,
                    SizedBox(
                      width: double.infinity,
                      child: Pinput(
                        controller: controller.codeController,
                        defaultPinTheme: PinTheme(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromRGBO(241, 240, 245, 1))),
                        errorTextStyle: getRegularStyle(color: Colors.red),
                        validator: AppValidator.otpValidator,
                        length: 6,
                        onCompleted: (val) {
                          // controller.signInWithPhoneNumber(
                          //     verificationId: verificationId,
                          //     SmsCode: val,
                          //     context: context);
                        },
                      ),
                    ),
                    20.ph,
                  ]),
                ),
              ),
              20.ph,
              isLoading
                  ? CircularProgressIndicator()
                  : MyButton(
                      title: 'Verify',
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          controller.signInWithPhoneNumber(
                              verificationId: verificationId,
                              SmsCode: controller.codeController.text,
                              context: context);
                        }
                      },
                    ),
              40.ph
            ],
          ),
        ),
      ),
    );
  }
}
