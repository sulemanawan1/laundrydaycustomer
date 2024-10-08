import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundryday/helpers/validation_helper.dart';
import 'package:laundryday/screens/add_laundry/presentation/provider/add_laundry_notifier.dart';
import 'package:laundryday/screens/add_laundry/presentation/provider/add_laundry_states.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

final contactInformationFormKey = GlobalKey<FormState>();

Widget contactInformation(BuildContext context,
    AddLaundryNotifier laundryNotifier, AddLaundryStates states) {
  return Form(
    key: contactInformationFormKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(
          title: 'Contact Information',
        ),
        8.ph,
        MyTextFormField(
          validator: AppValidator.emptyStringValidator,
          hintText: 'Ex : Ali',
          labelText: 'First Name',
          controller: laundryNotifier.firstNameController,
        ),
        8.ph,
        MyTextFormField(
          validator: AppValidator.emptyStringValidator,
          hintText: 'Ex : Ahmed',
          labelText: 'Last Name',
          controller: laundryNotifier.lastNameController,
        ),
        8.ph,
        MyTextFormField(
          validator: AppValidator.emailValidator,
          hintText: 'Ex : person@gmail.com',
          labelText: 'Email',
          controller: laundryNotifier.emailController,
        ),
        8.ph,
        MyTextFormField(
          validator: AppValidator.passwordValidator,
          hintText: 'Enter your password',
          labelText: 'Password',
          controller: laundryNotifier.passwordController,
        ),
        8.ph,
        MyTextFormField(
          textInputType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: AppValidator.validatePhoneNumber,
          controller: laundryNotifier.mobileNumberController,
          maxLength: 10,
          hintText: '5xxxxxxxx',
          labelText: 'Mobile Number',
          contentPadding: const EdgeInsets.only(top: AppPadding.p20),
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(
                end: AppPadding.p12,
                top: AppPadding.p14,
                start: AppPadding.p10),
            child: Text(
              '+966',
              style: getMediumStyle(color: ColorManager.blackColor),
            ),
          ),
          suffixIcon: Icon(
            Icons.phone_android,
            color: ColorManager.primaryColor,
          ),
        ),
        8.ph,
      ],
    ),
  );
}
