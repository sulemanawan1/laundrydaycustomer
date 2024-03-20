import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/Widgets/my_heading/heading.dart';
import 'package:laundryday/Widgets/my_textForm%20_field/my_textform_field.dart';
import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';

class ContactInformation extends StatelessWidget {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confrimPasswordController = TextEditingController();
  final _mobileNumberContactController = TextEditingController();

  ContactInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(
          text: 'Contact Information',
        ),
        8.ph,
        MyTextFormField(
          hintText: 'Ex : Ali',
          labelText: 'Full Name',
          controller: _fullNameController,
        ),
        8.ph,
        MyTextFormField(
          validator: ValidationHelper().emailValidator,
          hintText: 'Ex : person@gmail.com',
          labelText: 'Email',
          controller: _emailController,
        ),
        8.ph,
        MyTextFormField(
          validator: ValidationHelper().emailValidator,
          hintText: 'Ex : person@gmail.com',
          labelText: 'Confirm Email',
          controller: _confirmEmailController,
        ),
        8.ph,
        MyTextFormField(
          validator: ValidationHelper().passwordValidator,
          hintText: 'Enter your password',
          labelText: 'Password',
          controller: _passwordController,
        ),
        8.ph,
        MyTextFormField(
          validator: ValidationHelper().passwordValidator,
          hintText: 'Re-enter your password',
          labelText: 'Confirm Password',
          controller: _confrimPasswordController,
        ),
        8.ph,
        MyTextFormField(
          controller: _mobileNumberContactController,
          textInputType: TextInputType.number,
          maxLength: 9,
          validator: ValidationHelper().validatePhoneNumber,
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
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          suffixIcon: Icon(
            Icons.phone_android,
            color: ColorManager.primaryColor,
          ),
        ),
        8.ph,
      ],
    );
  }
}
