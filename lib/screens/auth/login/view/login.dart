import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
import 'package:laundryday/screens/auth/login/provider/login_notifier.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/auth/verification/provider/verification_notifier.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/font_manager.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/constants/value_manager.dart';
import 'package:laundryday/core/theme/styles_manager.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/core/widgets/my_textform_field.dart';

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
                        title: 'Laundry DAY',
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(9),
                        ],
                        textColor: ColorManager.whiteColor,
                        fillColor: ColorManager.tranparentColor,
                        hintTextColor: ColorManager.whiteColor,
                        labelTextColor: ColorManager.whiteColor,
                        controller: controller.phoneController,
                        validator: AppValidator.validatePhoneNumber,
                        autofillHints: const [
                          AutofillHints.telephoneNumberLocalSuffix
                        ],
                        hintText: '5xxxxxxxx',
                        labelText: 'Mobile Number',
                        prefixIcon: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 40,
                            minHeight: 40,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 15),
                            child: Text(
                              '+966',
                              style: getMediumStyle(
                                  color: ColorManager.whiteColor,
                                  fontSize: FontSize.s12),
                            ),
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.phone_android,
                          color: ColorManager.whiteColor,
                          size: AppSize.s14,
                        ),
                      ),
                      10.ph,
                      isLoading
                          ? CircularProgressIndicator()
                          : MyButton(
                              title: 'Continue',
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
