import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/models/user_model.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/home/provider/home_notifier.dart';
import 'package:laundryday/screens/more/profile/provider/change_mobile_number_notifier.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

class ChangeMobileNumber extends ConsumerWidget {
  final UserModel userModel;
  const ChangeMobileNumber({super.key, required this.userModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(changeMobileNumberProvider.notifier);
    final isLoading = ref.watch(changeMobileNumberProvider).isLoading;
    final key = GlobalKey<FormState>();

    return Scaffold(
      appBar: MyAppBar(
        title: 'Change Mobile Number',
      ),
      body: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(title: 'Edit Mobile Number'),
                  20.ph,
                  HeadingMedium(
                    title:
                        "Add your Mobile number. We'll send you a verification code",
                  ),
                  20.ph,
                  MyTextFormField(
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                    ],
                    controller: controller.mobileNumber,
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
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s12),
                        ),
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.phone_android,
                      color: ColorManager.greyColor,
                      size: AppSize.s14,
                    ),
                  ),
                  10.ph,
                  isLoading
                      ? CircularProgressIndicator()
                      : MyButton(
                          title: 'Change Mobile Number',
                          onPressed: () async {
                            log(userModel.user!.mobileNumber.toString());
                            log(controller.mobileNumber.text);
                            if (key.currentState!.validate()) {
                              if ("+966" + controller.mobileNumber.text ==
                                  userModel.user!.mobileNumber.toString()) {
                                ref
                                    .read(homeProvider.notifier)
                                    .changeIndex(index: 0, ref: ref);

                                Utils.showToast(
                                    msg: 'Mobile Number Updated Successfully');
                                context.goNamed(RouteNames.home);
                              }
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
    );
  }
}
