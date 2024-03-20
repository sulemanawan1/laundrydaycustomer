import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/Widgets/my_heading/heading.dart';
import 'package:laundryday/Widgets/my_textForm%20_field/my_textform_field.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/more/help/business_partner/business_partner.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_notifier.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/reusable_document_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class BusinessInformation extends ConsumerWidget {
  final _storeNameEnglish = TextEditingController();
  final _storeNameArabic = TextEditingController();
  final _registrationNumber = TextEditingController();
  final _taxNumber = TextEditingController();
  final _branchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.watch(bussinessPartnerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(text: 'Tell us about your business'),
        8.ph,
        MyTextFormField(
          hintText: 'Ex : Aljabr',
          labelText: 'Store Name in English',
          controller: _storeNameEnglish,
        ),
        8.ph,
        MyTextFormField(
          hintText: 'Ex : الجبر',
          labelText: 'Store Name in Arabic',
          controller: _storeNameArabic,
        ),
        8.ph,
        MyTextFormField(
          hintText: '8477474747474747727',
          labelText: 'Commercial registration no.',
          controller: _registrationNumber,
        ),
        8.ph,
        MyTextFormField(
          hintText: '8477474747474747727',
          labelText: 'Tax Number',
          controller: _taxNumber,
        ),
        8.ph,
        const HeadingSmall(title: 'Category'),
        DropdownButton<CategoryType>(
            isExpanded: true,
            padding: EdgeInsets.zero,
            value: states.categoryType,
            onChanged: (CategoryType? newValue) {
              if (newValue != null) {
                states.categoryType = newValue;
              }
            },
            items: CategoryType.values.map((CategoryType type) {
              return DropdownMenuItem<CategoryType>(
                value: type,
                child: Text(
                  type == CategoryType.laundry ? 'Laundry' : 'Laundry',
                  style: GoogleFonts.poppins(),
                ),
              );
            }).toList()),
        5.ph,
        
        MultiSelectDialogField(backgroundColor: ColorManager.mediumWhiteColor,
          unselectedColor: Colors.white,
          
          selectedColor: ColorManager.primaryColor,
          selectedItemsTextStyle: GoogleFonts.poppins(color:ColorManager.blackColor),
          buttonIcon: const Icon(Icons.arrow_drop_down),
          title: const Text('Select Services'),
          items: states.items.map((e) => MultiSelectItem(e, e.name)).toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: (values) {
            states.copyWith(selectedItems: values);
          },
        ),
        8.ph,
        MyTextFormField(
          hintText: 'Branches',
          labelText: 'Branches',
          controller: _branchController,
        ),
        8.ph,
        const HeadingSmall(title: 'Upload required files'),
        8.ph,
        ResuableDocumentPicker(
            onTap: () {
              ref
                  .read(bussinessPartnerProvider.notifier)
                  .pickImage(imageSource: ImageSource.gallery);
            },
            imageFile: states.image,
            title: "Commercial Registration Image"),
        8.ph,
      ],
    );
  }
}
