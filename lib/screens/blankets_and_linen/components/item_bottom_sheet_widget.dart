import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/blankets_and_linen/view/blankets_category.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_loader.dart';

class ItemBottomSheet extends ConsumerWidget {

 final ItemModel itemModel;
   ItemBottomSheet({super.key, required this. itemModel});

  @override
  Widget build(BuildContext context, WidgetRef reff) {

    final blankets = reff.watch(blanketAndLinenProvider);
    final loader = reff.watch(isLoadingProductsProvider);
    return loader == false && blankets.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadingMedium(title: itemModel.name.toString()),
                    IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: ColorManager.greyColor,
                        ))
                  ],
                ),
                Flexible(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => 10.ph,
                    shrinkWrap: true,
                    itemCount: blankets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 6,
                        child: ListTile(
                          trailing: quantityAddRemoveCard(
                              context: context,
                              blankets: blankets[index],
                              onTapRemoveQuantity: () {
                                reff
                                    .read(blanketAndLinenProvider.notifier)
                                    .removeQuantity(id: blankets[index].id);
                              },
                              onTapAddQuantity: () {
                                reff
                                    .read(blanketAndLinenProvider.notifier)
                                    .addQuantity(id: blankets[index].id);

                                reff
                                    .read(selectedItemNotifier.notifier)
                                    .checkAndUpdate(
                                        id: blankets[index].id,
                                        blankets: blankets[index],
                                        categoryId: itemModel.categoryId);
                              }),
                          title: Text(
                            blankets[index].name.toString(),
                            maxLines: 2,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppPadding.p10),
                            child: Text(
                              "${blankets[index].initialCharges.toString()} SAR",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  color: ColorManager.blackColor),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                5.ph,
                GestureDetector(
                  onTap: () async {
                    reff.read(selectedItemsCountNotifier.notifier).state =
                        reff.read(selectedItemNotifier.notifier).state.length;

                    context.pop();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Heading(
                                  text: "SAR 0.0",
                                  color: ColorManager.whiteColor,
                                ),
                                Heading(
                                  text: 'Add',
                                  color: ColorManager.whiteColor,
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
                20.ph,
              ],
            ),
          )
        : const Loader();
  }
}
 Widget quantityAddRemoveCard(
      {required BuildContext context,
      required ItemModel blankets,
      required void Function()? onTapRemoveQuantity,
      required void Function()? onTapAddQuantity}) {
    return Container(
      height: 30,
      decoration: ShapeDecoration(
          color: ColorManager.primaryColor.withOpacity(0.2),
          shape: const StadiumBorder()),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                constraints: const BoxConstraints(maxWidth: 30, minHeight: 30),
                padding: const EdgeInsets.only(left: 5),
                onPressed: onTapRemoveQuantity,
                icon: Icon(
                  Icons.remove,
                  color: ColorManager.blackColor,
                  size: 18,
                )),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 40, minWidth: 40),
              child: Center(
                child: Text(
                  blankets.quantity.toString(),
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            IconButton(
                constraints: const BoxConstraints(maxWidth: 30, minHeight: 30),
                padding: const EdgeInsets.only(right: 5),
                onPressed: onTapAddQuantity,
                icon: Icon(
                  Icons.add,
                  color: ColorManager.blackColor,
                  size: 18,
                )),
          ]),
    );
  }


 


 
