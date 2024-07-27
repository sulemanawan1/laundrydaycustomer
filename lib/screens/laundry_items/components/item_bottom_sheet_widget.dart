import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/core/widgets/my_loader.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/constants/value_manager.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_item_states.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_items.notifier.dart';

class ItemBottomSheet extends ConsumerWidget {
  ItemBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemVariationStates =
        ref.watch(laundryItemProver).itemVariationStates;
    final itemVariationList = ref.watch(laundryItemProver).itemVariationList;

    if (itemVariationStates is ItemVariationIntitialState) {
      return Loader();
    } else if (itemVariationStates is ItemVariationLoadingState) {
      Loader();
    } else if (itemVariationStates is ItemVariationErrorState) {
      return Text(itemVariationStates.errorMessage);
    } else if (itemVariationStates is ItemVariationLoadedState) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // HeadingMedium(title: itemModel.name.toString()),
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
                  itemCount: itemVariationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    ItemVariation itemVariation = itemVariationList[index];

                    return Card(
                      elevation: 6,
                      child: Column(
                        children: [
                          ListTile(
                            trailing: quantityAddRemoveCard(
                                onTapAddQuantity: () {
                                  DatabaseHelper.instance
                                      .insertItemVariation(itemVariation)
                                      .then((v) {
                                    print(v);
                                  }).onError((e, r) {
                                    print(e);
                                  });

                                  ref
                                      .read(laundryItemProver.notifier)
                                      .addQuantity(id: itemVariation.id);
                                },
                                context: context,
                                blankets: itemVariation,
                                onTapRemoveQuantity: () {
                                  ref
                                      .read(laundryItemProver.notifier)
                                      .removeQuantity(id: itemVariation.id);
                                }),
                            title: Text(
                              itemVariation.name.toString(),
                              maxLines: 2,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p10),
                              child: Text(
                                "${itemVariation.price.toString()} SAR",
                                maxLines: 2,
                                style: GoogleFonts.poppins(
                                    color: ColorManager.blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              5.ph,
              GestureDetector(
                onTap: () {
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
                                title: "SAR 0.0",
                                color: ColorManager.whiteColor,
                              ),
                              Heading(
                                title: 'Add',
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
          ));
    }
    return Loader();
  }
}

Widget quantityAddRemoveCard(
    {required BuildContext context,
    required ItemVariation blankets,
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
