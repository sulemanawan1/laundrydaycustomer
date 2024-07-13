import 'package:flutter/material.dart';
import 'package:laundryday/helpers/validation_helper/validation_helper.dart';
import 'package:laundryday/screens/add_laundry/provider/add_laundry_notifier.dart';
import 'package:laundryday/screens/add_laundry/provider/add_laundry_states.dart';
import 'package:laundryday/utils/constants/colors.dart';
import 'package:laundryday/utils/constants/font_manager.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/constants/value_manager.dart';
import 'package:laundryday/utils/theme/styles_manager.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/resuable_dropdown.dart';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import '../../../../../widgets/my_textform_field.dart';

final businessInformationFormKey = GlobalKey<FormState>();

Widget bussinessInformation(BuildContext context,
    AddLaundryNotifier laundryNotifier, AddLaundryStates states) {
  var servicesModel = states.servicesModel;
  return Form(
    key: businessInformationFormKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(title: 'Store Info'),
        8.ph,
        MyTextFormField(
          validator: AppValidator().emptyStringValidator,
          hintText: 'Ex : Aljabr',
          labelText: 'Store Name in English',
          controller: laundryNotifier.nameController,
        ),
        8.ph,
        MyTextFormField(
          validator: AppValidator().emptyStringValidator,
          hintText: 'Ex : الجبر',
          labelText: 'Store Name in Arabic',
          controller: laundryNotifier.arabicNameController,
        ),
        8.ph,
        ReusableDropMenu(
          onSelected: (type) => {
            laundryNotifier.setType(type: type!)},
          list:
              ["Laundry", "Central Laundry", "Laundry (Furnitures-Houses-Cars)"]
                  .map((e) => DropdownMenuEntry(
                        value: e,
                        label: e,
                      ))
                  .toList(),
          label: 'Select the Type',
        ),
        10.ph,
        if (servicesModel != null) ...[
          MultiSelectDialogField(
            isDismissible: true,
            buttonText: Text(
              'Select Service',
              style: getSemiBoldStyle(
                  color: ColorManager.blackColor, fontSize: FontSize.s10),
            ),
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(AppSize.s8),
              border: Border.fromBorderSide(BorderSide(
                  color: ColorManager.lightGrey, width: AppSize.s1_5)),
            ),
            backgroundColor: ColorManager.whiteColor,
            unselectedColor: ColorManager.whiteColor,
            selectedColor: ColorManager.primaryColor,
            selectedItemsTextStyle: getMediumStyle(
                color: ColorManager.blackColor, fontSize: FontSize.s10),
            buttonIcon: const Icon(Icons.arrow_drop_down),
            title: const Text('Services'),
            items: servicesModel.data!
                .map((e) => MultiSelectItem(e, e.serviceName.toString()))
                .toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              laundryNotifier.addServiceIds(values: values);
            },
          ),
        ],
        8.ph,
      ],
    ),
  );
}
