import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_textformfields.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

class ContactInformation extends ConsumerWidget {
  const ContactInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: BusinessPartnerTextFormFields.formKey4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(
            text: 'Contact Information',
          ),
          8.ph,
          MyTextFormField(
            validator: ValidationHelper().emptyStringValidator,
            hintText: 'Ex : Ali',
            labelText: 'First Name',
            controller: BusinessPartnerTextFormFields.firstNameController,
          ),
          8.ph,
          MyTextFormField(
            validator: ValidationHelper().emptyStringValidator,
            hintText: 'Ex : Ahmed',
            labelText: 'Last Name',
            controller: BusinessPartnerTextFormFields.lastNameController,
          ),
          8.ph,
          MyTextFormField(
            validator: ValidationHelper().emailValidator,
            hintText: 'Ex : person@gmail.com',
            labelText: 'Email',
            controller: BusinessPartnerTextFormFields.emailController,
          ),
          8.ph,
          MyTextFormField(
            validator: ValidationHelper().emailValidator,
            hintText: 'Ex : person@gmail.com',
            labelText: 'Confirm Email',
            controller: BusinessPartnerTextFormFields.confirmEmailController,
          ),
          8.ph,
          MyTextFormField(
            validator: ValidationHelper().passwordValidator,
            hintText: 'Enter your password',
            labelText: 'Password',
            controller: BusinessPartnerTextFormFields.passwordController,
          ),
          8.ph,
          MyTextFormField(
            validator: ValidationHelper().passwordValidator,
            hintText: 'Re-enter your password',
            labelText: 'Confirm Password',
            controller: BusinessPartnerTextFormFields.confrimPasswordController,
          ),
          8.ph,
          MyTextFormField(
             textInputType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
                  
            validator: ValidationHelper(). validatePhoneNumber,
            controller:
                BusinessPartnerTextFormFields.mobileNumberContactController,
            maxLength: 9,
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
      ),
    );
  }
}
