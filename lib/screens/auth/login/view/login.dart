import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/resources/app_strings.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/screens/auth/login/provider/login_notifier.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

class Login extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(loginProvider.notifier);
    final isLoading = ref.watch(loginProvider).isLoading;

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppStrings.loginTitle1,
                        style: getSemiBoldStyle(
                            color: ColorManager.whiteColor,
                            fontSize: FontSize.s20),
                      ).tr(),
                      14.ph,
                      Text(
                        AppStrings.loginTitle2,
                        style: getSemiBoldStyle(
                            color: ColorManager.whiteColor,
                            fontSize: FontSize.s14),
                      ).tr(),
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
                        labelText: '',
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
                      20.ph,
                      isLoading
                          ? CircularProgressIndicator()
                          : MyButton(
                              title: context.tr(AppStrings.next),
                              onPressed: () async {

                                // log(lng!.languageCode.toString());

                                if (key.currentState!.validate()) {
                                  // final smartAuth = SmartAuth();

                                  // String? appSignatureID =
                                  //     await smartAuth.getAppSignature();

                                  // if (appSignatureID != null) {
                                  //   log(appSignatureID.toString());
                                  //   log(controller.phoneController.text
                                  //       .toString());
                                  // }

                                  controller.verifyPhoneNumber(
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
