import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/Widgets/my_heading/heading.dart';
import 'package:laundryday/Widgets/my_textForm%20_field/my_textform_field.dart';
import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/help/business_partner/components/service_widget.dart';
import 'package:laundryday/screens/more/help/business_partner/components/type_widget.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_notifier.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_textformfields.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class BusinessInformation extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states =ref.watch(businessPartnerProvider);
    return Form(
      key: BusinessPartnerTextFormFields.formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(text: 'Store Info'),
          8.ph,
          MyTextFormField(
            validator: ValidationHelper().emptyStringValidator,
            hintText: 'Ex : Aljabr',
            labelText: 'Store Name in English',
            controller: BusinessPartnerTextFormFields.storeNameEnglish,
          ),
          8.ph,
          MyTextFormField(
            validator: ValidationHelper().emptyStringValidator,
            hintText: 'Ex : الجبر',
            labelText: 'Store Name in Arabic',
            controller: BusinessPartnerTextFormFields.storeNameArabic,
          ),
          8.ph,
          const HeadingSmall(title: 'Select the Type'),
          8.ph,
          const TypeWidget(),
        10.ph,
           const HeadingSmall(title: 'Select the Service'),
          8.ph,
          const ServiceWidget(),
          8.ph,
        ],
      ),
    );
  }
}
