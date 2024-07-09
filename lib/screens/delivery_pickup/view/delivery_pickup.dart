import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/delivery_pickup/components/add_new_item_widget.dart';
import 'package:laundryday/screens/delivery_pickup/components/extra_quantity_charges_widget.dart';
import 'package:laundryday/screens/delivery_pickup/components/scan_receipt_widget.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_notifier.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_states.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/address_detail_widget.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/reusable_laundry_detail_card.dart';

enum RecievingMethodTypes { outsidedoor, dooroftheapartment }

final deliverPickupProvider = StateNotifierProvider.autoDispose<
    DeliveryPickupNotifier,
    DeliveryPickupStates>((ref) => DeliveryPickupNotifier(ref: ref));

class DeliveryPickup extends ConsumerStatefulWidget {
  final Arguments? arguments;

  const DeliveryPickup({super.key, required this.arguments});

  @override
  ConsumerState<DeliveryPickup> createState() => _DeliveryPickupState();
}

class _DeliveryPickupState extends ConsumerState<DeliveryPickup> {
  final formkey = GlobalKey<FormState>();
  RecievingMethodTypes site = RecievingMethodTypes.outsidedoor;

  @override
  void initState() {
    super.initState();

    ref
        .read(deliverPickupProvider.notifier)
        .fetchAllItems(serviceId: widget.arguments!.laundryModel!.service!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Delivery Pickup',
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.9,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      ReuseableLaundryDetailCard(
                          laundryModel: widget.arguments!.laundryModel!),
                      10.ph,
                      const AddressDetailWidget(),
                      20.ph,
                      const ScanReceiptWidget(),
                      20.ph,
                      ItemListWidget(
                        servicesModel: widget.arguments!.laundryModel!.service!,
                      ),
                      10.ph,
                      // RecievingMethod(),
                      DeliveryFeeWidget(
                          servicesModel:
                              widget.arguments!.laundryModel!.service)
                    ]),
                  ),
                ),
                NextWiget(
                  laundryModel: widget.arguments!.laundryModel!,
                  constraints: constraints,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class NextWiget extends ConsumerWidget {
  final LaundryModel laundryModel;
  BoxConstraints constraints;

  NextWiget({super.key, required this.laundryModel, required this.constraints});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: constraints.maxHeight * 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyButton(
            title: 'Next',
            onPressed: () {
              ref.read(deliverPickupProvider.notifier).goToOrderReview(
                  context: context, laundryModel: laundryModel);
            },
          ),
          20.ph,
        ],
      ),
    );
  }
}

class DeliveryFeeWidget extends StatelessWidget {
  ServicesModel? servicesModel;
  DeliveryFeeWidget({super.key, this.servicesModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            HeadingMedium(title: "Delivery Fee"),
            HeadingMedium(title: servicesModel!.deliveryFee.toString())
          ]),
        ),
      ),
    );
  }
}

class Arguments {
  LaundryModel? laundryModel;

  Arguments({required this.laundryModel});
}

class ItemListWidget extends ConsumerWidget {
  ServicesModel servicesModel;
  ItemListWidget({super.key, required this.servicesModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final laundryItemList = ref.watch(deliverPickupProvider).laundryItemList;

    final selectedPickUpItem =
        ref.watch(deliverPickupProvider).laundryItemModel;
    final quantity = ref.watch(deliverPickupProvider).quanitiy;

    final selectedItemList = ref.watch(deliverPickupProvider).selectedItems;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading(title: 'Item Details'),
            10.ph,
            HeadingMedium(
              title: 'Describe your courier what do you need',
              color: ColorManager.greyColor,
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: ColorManager.greyColor, width: 0.4)),
                      child: DropdownButton<ItemModel>(
                        padding: const EdgeInsets.only(left: AppPadding.p10),
                        underline: const SizedBox(),
                        hint: const Text('Select Item'),
                        elevation: 8,
                        isExpanded: true,
                        menuMaxHeight: 500,
                        items: laundryItemList!.map((ItemModel? orderItem) {
                          return DropdownMenuItem<ItemModel>(
                            value: orderItem,
                            child: Text(
                              orderItem?.name.toString() ?? "",
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (ItemModel? val) {
                          log(val.toString());

                          ref
                              .read(deliverPickupProvider.notifier)
                              .selectBlanketItem(laundryItem: val!);
                        },
                        value: selectedPickUpItem,
                      ),
                    ),
                  ),
                  10.pw,
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: ColorManager.greyColor, width: 0.5)),
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  ref
                                      .read(deliverPickupProvider.notifier)
                                      .removeQuantitiy();
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                )),
                          ),
                          Text(
                            quantity.toString(),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  ref
                                      .read(deliverPickupProvider.notifier)
                                      .addQuantitiy(
                                          servicesModel: servicesModel);
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: ColorManager.primaryColor,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (servicesModel.id == 1) ...[
              quantity! > 7
                  ? const ExtraQuantityChargesWidget(
                      title: '7 max. +0.50 SAR/ex.')
                  : const SizedBox()
            ] else if (servicesModel.id == 2) ...[
              quantity! > 3
                  ? const ExtraQuantityChargesWidget(
                      title: '3 max. +2 SAR/ex.',
                    )
                  : const SizedBox(),
            ],
            10.ph,
            const AddNewItemWidget(),
            10.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Heading(title: 'Order Items'),
                10.ph,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedItemList!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: ColorManager.mediumWhiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: ListTile(
                          leading: selectedItemList[index].name == 'receipt'
                              ? GestureDetector(
                                  onTap: () {
                                    context.pushNamed(RouteNames().viewImage,
                                        extra: selectedItemList[index].image);
                                  },
                                  child: Hero(
                                    tag: 'reciept',
                                    child: Image.file(File(
                                        selectedItemList[index]
                                            .image
                                            .toString())),
                                  ))
                              : null,
                          title: Text(
                            selectedItemList[index].name.toString(),
                          ),
                          subtitle: selectedItemList[index].name == 'receipt'
                              ? const SizedBox()
                              : Text(
                                  'Quantity : ${selectedItemList[index].quantity}'),
                          trailing: IconButton(
                              onPressed: () {
                                ref
                                    .read(deliverPickupProvider.notifier)
                                    .deleteItem(id: selectedItemList[index].id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
