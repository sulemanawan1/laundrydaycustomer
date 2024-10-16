import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/profile/provider/change_mobile_number_verification_notifier.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:pinput/pinput.dart';

class ChangeMobileNumberVerification extends ConsumerWidget {
  final String verificationId;

  ChangeMobileNumberVerification({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        ref.read(changeMobileNumberVerificationProvider.notifier);
    final isLoading =
        ref.watch(changeMobileNumberVerificationProvider).isLoading;
    final key = GlobalKey<FormState>();
    return Scaffold(
      appBar: MyAppBar(
        title: 'Verification',
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: Column(
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
                    const Heading(title: 'Verification'),
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
                          // controller.signInWithPhoneNumber(ref: ref,
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
                          controller.signInWithPhoneNumber(ref: ref,
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
