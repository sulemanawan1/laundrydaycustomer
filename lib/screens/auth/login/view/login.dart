import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
import 'package:laundryday/screens/auth/login/provider/login_notifier.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/auth/verification/provider/verification_notifier.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_textform_field.dart';
class Login extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(loginProvider.notifier);
    final isLoading = ref.watch(loginProvider).isLoading;

    final codeController =
        ref.read(verificationProvider.notifier).codeController;

    final key = GlobalKey<FormState>();

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/login.jpg"), fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
              ColorManager.blackOpacity45,
              ColorManager.blackColor,
            ])),
        child: Scaffold(
          backgroundColor: ColorManager.tranparentColor,
          body: Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Heading(
                        text: 'Laundry DAY',
                        color: ColorManager.whiteColor,
                      ),
                      14.ph,
                      HeadingMedium(
                        textAlign: TextAlign.center,
                        title:
                            "Add your Mobile number. We'll send you a \n verification code",
                        color: ColorManager.whiteColor,
                      ),
                      10.ph,
                      MyTextFormField(
                        textInputType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textColor: ColorManager.whiteColor,
                        fillColor: ColorManager.tranparentColor,
                        hintTextColor: ColorManager.whiteColor,
                        labelTextColor: ColorManager.whiteColor,
                        maxLength: 9,
                        controller: controller.phoneController,
                        validator: ValidationHelper().validatePhoneNumber,
                        autofillHints: const [
                          AutofillHints.telephoneNumberLocalSuffix
                        ],
                        hintText: '5xxxxxxxx',
                        labelText: 'Mobile Number',
                        contentPadding:
                            const EdgeInsets.only(top: AppPadding.p20),
                        prefixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              end: AppPadding.p12,
                              top: AppPadding.p14,
                              start: AppPadding.p10),
                          child: Text(
                            '+966',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: ColorManager.whiteColor,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.phone_android,
                          color: ColorManager.whiteColor,
                        ),
                      ),
                      10.ph,
                      isLoading
                          ? CircularProgressIndicator()
                          : MyButton(
                              name: 'Continue',
                              onPressed: () {
                                if (key.currentState!.validate()) {
                                  controller.verifyPhoneNumber(
                                      codeController: codeController,
                                      context: context);
                                }
                              },
                            ),
                      40.ph,
                    ]),
              )),
        ),
      ),
    );
  }
}
