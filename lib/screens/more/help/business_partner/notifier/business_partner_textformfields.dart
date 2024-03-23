import 'package:flutter/material.dart';

class BusinessPartnerTextFormFields {
  BusinessPartnerTextFormFields._();

  static final storeNameEnglish = TextEditingController();
  static final storeNameArabic = TextEditingController();
  static final registrationNumber = TextEditingController();
  static final branchController = TextEditingController();
  static final taxNumber = TextEditingController();

  static final firstNameController = TextEditingController();
  static final lastNameController = TextEditingController();

  static final emailController = TextEditingController();
  static final confirmEmailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final confrimPasswordController = TextEditingController();
  static final mobileNumberContactController = TextEditingController();


  static disposeController()
  {
storeNameEnglish.dispose();
   storeNameArabic.dispose();
taxNumber.dispose();
    registrationNumber.dispose();
    branchController.dispose();
 firstNameController.dispose();
    lastNameController.dispose();
emailController.dispose();
   confirmEmailController.dispose();
    passwordController.dispose();
   confrimPasswordController.dispose();
    mobileNumberContactController.dispose();



  }

  static cleartAllTextFormFields() {
    storeNameEnglish.clear();
    storeNameArabic.clear();
    taxNumber.clear();
    registrationNumber.clear();
    branchController.clear();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    confirmEmailController.clear();
    passwordController.clear();
    confrimPasswordController.clear();
    mobileNumberContactController.clear();
  }
}
