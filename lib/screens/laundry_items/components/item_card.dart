import 'package:flutter/material.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/widgets/custom_cache_netowork_image.dart';

class ItemCard extends StatelessWidget {
  final void Function()? onTap;
  final Item item;

  ItemCard({super.key, this.onTap, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Badge(
        isLabelVisible: item.count == null ? false : true,
        offset: Offset(-10, 10),
        label: Text(item.count.toString()),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 110,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side:
                          BorderSide(color: ColorManager.greyColor, width: 0.2),
                    ),
                    elevation: AppSize.s1_0,
                    child: Center(
                        child: CustomCacheNetworkImage(
                      imageUrl: Api.imageUrl + item.image.toString(),
                      height: AppSize.s65,
                    )),
                  ),
                ),
              ],
            ),
            4.ph,
            Text(
              item.name.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: getSemiBoldStyle(
                  color: ColorManager.blackColor, fontSize: FontSize.s12),
            )
          ],
        ),
      ),
    );

    
  }
}
