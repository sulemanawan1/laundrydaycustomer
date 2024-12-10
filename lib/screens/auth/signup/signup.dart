import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/screens/auth/signup/provider/signup_notifier.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

class SignUp extends ConsumerWidget {
  final String mobileNumber;
  final formKey = GlobalKey<FormState>();

  SignUp({super.key, required this.mobileNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(signupProvider.notifier);
    final states = ref.watch(signupProvider);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(mobileNumber),

            Text("Enter your Full Name?",style: getSemiBoldStyle(color: ColorManager.blackColor),)
           ,
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: MyTextFormField(
                      controller: controller.firstNameController,
                      validator: AppValidator.emptyStringValidator,
                      hintText: 'First Name.',
                      labelText: 'First Name.',
                      autofillHints: const [AutofillHints.name],
                    ),
                  ),
                  5.pw,
                  Expanded(
                    child: MyTextFormField(
                      controller: controller.lastNameController,
                      validator: AppValidator.emptyStringValidator,
                      hintText: 'Last Name.',
                      labelText: 'Last Name',
                      autofillHints: const [AutofillHints.name],
                    ),
                  ),
                ],
              ),
            ),
            states.isLoading
                ? Center(child: CircularProgressIndicator())
                : MyButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.registerUser(
                            context: context,
                            mobileNumber: mobileNumber,
                            firstName: controller.firstNameController.text,
                            lastName: controller.lastNameController.text);
                      }
                    },
                    title: 'Continue',
                  ),
            40.ph,
          ],
        ),
      ),
    ));
  }
}

// ignore: must_be_immutable
class HeadingMedium extends StatelessWidget {
  final String title;
  Color? color;
  TextAlign? textAlign;

  HeadingMedium({super.key, required this.title, this.color, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          getMediumStyle(color: color ?? ColorManager.blackColor, fontSize: 14),
      textAlign: textAlign,
    );
  }
}
