import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/screens/laundry_items/components/item_bottom_sheet_widget.dart';
import 'package:laundryday/screens/laundry_items/view/laundry_items.dart';
import 'package:laundryday/utils/constants/colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/constants/value_manager.dart';

class ItemLists extends ConsumerWidget {
  final List<ItemModel> item;
  const ItemLists({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: item.length,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p10, vertical: AppPadding.p10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 180,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _itemCard(
            blanketItem: item[index],
            onTap: () {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  context: context,
                  builder: ((context) {
                    ref
                        .read(blanketAndLinenProvider.notifier)
                        .fetchLaundryItemSubCategories(itemId: item[index].id!);

                    return ItemBottomSheet(itemModel: item[index]);
                  }));
            });
      },
    );
  }

  Widget _itemCard(
      {void Function()? onTap, required ItemModel blanketItem}) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 8, end: 8),
      badgeContent: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          '1',
          style: GoogleFonts.poppins(color: ColorManager.whiteColor),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 130,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side:
                          BorderSide(color: ColorManager.greyColor, width: 0.2),
                    ),
                    elevation: 1,
                    child: Center(
                        child: Image.asset(blanketItem.image.toString(),
                            width: 80, height: 80)),
                  ),
                ),
              ],
            ),
            4.ph,
            Text(
              blanketItem.name.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
