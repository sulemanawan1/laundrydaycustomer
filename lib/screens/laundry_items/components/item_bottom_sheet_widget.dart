import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/widgets/my_loader.dart';
import 'package:laundryday/services/resources/colors.dart';
import 'package:laundryday/services/resources/sized_box.dart';
import 'package:laundryday/services/resources/value_manager.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_item_states.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_items.notifier.dart';

class ItemBottomSheet extends ConsumerWidget {
  final Item? selectedItem;
  ItemBottomSheet({super.key, this.selectedItem});

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
                                  ref
                                      .read(laundryItemProver.notifier)
                                      .quantityIncrement(id: itemVariation.id);

                                  ref
                                      .read(laundryItemProver.notifier)
                                      .totalItemPrice(
                                          selectedItem: selectedItem!);
                                },
                                context: context,
                                blankets: itemVariation,
                                onTapRemoveQuantity: () {
                                  ref
                                      .read(laundryItemProver.notifier)
                                      .quanitiyDecrement(id: itemVariation.id);

                                  ref
                                      .read(laundryItemProver.notifier)
                                      .totalItemPrice(
                                          selectedItem: selectedItem!);
                                }),
                            title: Text(
                              itemVariation.name.toString(),
                              maxLines: 2,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p10),
                              child: Text(
                                "${itemVariation.price!.toStringAsFixed(2)} SAR",
                                maxLines: 2,
                                style: getSemiBoldStyle(
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
              itemVariationStates.dataSource == 'api'
                  ? GestureDetector(
                      onTap: itemVariationList.map((e) => e.quantity == 0) ==
                              true
                          ? null
                          : () async {
                              DatabaseHelper.instance
                                  .insertItemVariations(itemVariationList);

                              ref
                                  .read(laundryItemProver.notifier)
                                  .totalItemCount(selectedItem: selectedItem!);

                              await DatabaseHelper.instance
                                  .insertItem(selectedItem!);

                              ref.read(laundryItemProver.notifier).getCount();
                              ref.read(laundryItemProver.notifier).getTotal();
                              context.pop();
                            },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p10),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Heading(
                                    //   title: itemsTotalPrice
                                    //       .abs()
                                    //       .toStringAsFixed(2),
                                    //   color: ColorManager.whiteColor,
                                    // ),
                                    Heading(
                                      title: selectedItem!.total_price != null
                                          ? selectedItem!.total_price!
                                              .abs()
                                              .toStringAsFixed(2)
                                          : "00.00",
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
                    )
                  : GestureDetector(
                      onTap: () async {
                        DatabaseHelper.instance
                            .updateItemVariations(itemVariationList);
                        ref
                            .read(laundryItemProver.notifier)
                            .totalItemCount(selectedItem: selectedItem!);

                        await DatabaseHelper.instance.updateItem(selectedItem!);

                        ref.read(laundryItemProver.notifier).getCount();
                        ref.read(laundryItemProver.notifier).getTotal();

                        context.pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p10),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Heading(
                                      title: selectedItem!.total_price != null
                                          ? selectedItem!.total_price!
                                              .abs()
                                              .toStringAsFixed(2)
                                          : "0.0",
                                      color: ColorManager.whiteColor,
                                    ),
                                    Heading(
                                      title: 'Edit',
                                      color: ColorManager.whiteColor,
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
              20.ph,

              // MyButton(
              //   title: 'Item',
              //   onPressed: () async {
              //     List<Item> item = await DatabaseHelper.instance.getAllItems();

              //     print(item.map((e) => e.count));
              //     print(item.map((e) => e.total_price));
              //   },
              // )
              // MyButton(
              //   title: 'Delete',
              //   onPressed: () async {
              //     int rows =
              //         await DatabaseHelper.instance.deleteItemVariationTable();
              //     print("${rows} Record  deleted");
              //   },
              // ),
              // 10.ph,
              // MyButton(
              //   title: 'Get',
              //   onPressed: () async {
              //     List<ItemVariation> items =
              //         await DatabaseHelper.instance.getAllItemVariations();

              //     for (int i = 0; i < items.length; i++) {
              //       print(items[i].quantity);
              //     }
              //   },
              // ),
              // 10.ph,
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
                style: getMediumStyle(color: ColorManager.blackColor),
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
