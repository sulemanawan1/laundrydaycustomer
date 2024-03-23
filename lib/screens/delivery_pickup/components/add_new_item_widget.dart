import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/blankets_model.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';

class AddNewItemWidget extends ConsumerWidget {
  const AddNewItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(deliverPickupProvider).quanitiy;

    final selectedItem = ref.watch(deliverPickupProvider).laundryItemModel;

    return GestureDetector(
      onTap: () {
        if (selectedItem == null || quantity == 0) {
          Fluttertoast.showToast(msg: 'Select an Item');
        } else {
          final LaundryItemModel item = LaundryItemModel(
              id: selectedItem.id, name: selectedItem.name, quantity: quantity);

          ref.read(deliverPickupProvider.notifier).addItem(item: item);

          ref.read(deliverPickupProvider.notifier).resetItemAndQuantity();
        }
      },
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: ColorManager.primaryColor,
          ),
          10.ph,
          Text(
            "Add New Item",
            style: GoogleFonts.poppins(
                color: ColorManager.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
