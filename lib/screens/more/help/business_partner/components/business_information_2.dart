import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/Widgets/my_textForm%20_field/my_textform_field.dart';
import 'package:laundryday/screens/more/help/business_partner/components/commercial_registration_image_widget.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_textformfields.dart';
import 'package:laundryday/screens/more/help/business_partner/view/business_partner.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/my_heading/heading.dart';

class BusinessInformation2 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.read(bussinessPartnerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(text: 'Documents'),
        8.ph,
        MyTextFormField(
          hintText: 'Branches',
          labelText: 'Branches',
          controller: BusinessPartnerTextFormFields.branchController,
        ),
        8.ph,
        MyTextFormField(
          hintText: '8477474747474747727',
          labelText: 'Tax Number',
          controller: BusinessPartnerTextFormFields.taxNumber,
        ),
        8.ph,
        MyTextFormField(
          hintText: '8477474747474747727',
          labelText: 'Commercial registration no.',
          controller: BusinessPartnerTextFormFields.registrationNumber,
        ),
        8.ph,
        const CommercialRegistrationImage(),
        8.ph,
      ],
    );
  }
}