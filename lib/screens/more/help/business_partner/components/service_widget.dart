import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/more/help/business_partner/view/business_partner.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class ServiceWidget extends ConsumerWidget {
  const ServiceWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context,WidgetRef ref) {
        final states = ref.watch(bussinessPartnerProvider);

    return MultiSelectDialogField(
      backgroundColor: ColorManager.mediumWhiteColor,
      unselectedColor: Colors.white,
      selectedColor: ColorManager.primaryColor,
      selectedItemsTextStyle:
          GoogleFonts.poppins(color: ColorManager.blackColor),
      buttonIcon: const Icon(Icons.arrow_drop_down),
      title: const Text('Services'),
      items: states.items.map((e) => MultiSelectItem(e, e.name)).toList(),
      listType: MultiSelectListType.CHIP,
      onConfirm: (values) {
        states.copyWith(selectedItems: values);
      },
    );
  }
}
