// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/carpets/carpet_service_detail/carpet_service_detail.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/screens/carpets/carpets_category/notifier/quantity_notifier.dart';
import 'package:laundryday/screens/carpet_order_checkout/notifiers/item_list_notifier.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';

// ignore: must_be_immutable
class CarpetOrderCheckout extends ConsumerStatefulWidget {
  // List<Items>? item;
  CarpetDetailsArguments orderDatailsArguments;

  CarpetOrderCheckout({super.key, required this.orderDatailsArguments});

  @override
  ConsumerState<CarpetOrderCheckout> createState() => _OrderCheckoutState();
}

class _OrderCheckoutState extends ConsumerState<CarpetOrderCheckout> {
  final dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();

    dbHelper
        .getItemList(laundryId: widget.orderDatailsArguments.laundry!.id)
        .then((value) {
      log("Laundry ID : ${widget.orderDatailsArguments.laundry!.id}");
      log("Service ID : ${widget.orderDatailsArguments.services!.id}");

      // ignore: invalid_use_of_protected_member
      ref.read(itemListProvider.notifier).state = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Review Order'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          15.ph,
          Expanded(child: _itemDetails(context)),
          15.ph,
          Expanded(
              child: _paymentSummary(
                  service: widget.orderDatailsArguments.services)),
          15.ph,
          MyButton(
            name: 'FIND COURIER',
            onPressed: () {},
          ),
          40.ph,
        ]),
      ),
    );
  }

  Widget _itemDetails(BuildContext context) {
    var item = ref.watch(itemListProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration:  BoxDecoration(color: ColorManager. mediumWhiteColor),
            width: MediaQuery.of(context).size.width,
            child: SwipeActionCell(
              key: ObjectKey(item),
              leadingActions: [
                SwipeAction(
                    icon:  Icon(
                      Icons.edit_square,
                      size: 30,
                      color: ColorManager.whiteColor,
                    ),
                    onTap: (CompletionHandler handler) async {
                      context.pop();
                    },
                    color: ColorManager.primaryColor),
              ],

              /// this key is necessary

              trailingActions: <SwipeAction>[
                SwipeAction(
                    icon:  Icon(
                      Icons.delete_outline_outlined,
                      size: 30,
                      color: ColorManager. whiteColor,
                    ),
                    onTap: (CompletionHandler handler) async {
                      ref.read(itemListProvider.notifier).deleteItem(
                          laundryId: widget.orderDatailsArguments.laundry!.id);

                      ref.read(quantityProvider.notifier).resetQuantity();
                      context.pop();
                    },
                    color: Colors.red),
              ],
              child: SingleChildScrollView(
                child: Card(
                  color: ColorManager.whiteColor,
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      10.ph,
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Heading(
                          text: 'Carpets',
                          color: ColorManager.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${item[index]!.name.toString()}(x${item[index]!.quantity.toString()})"),
                                    Text(
                                      "${item[index]!.quantity! * item[index]!.initialCharges!}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                item[index]!.category == 'mats'
                                    ? Container()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "L: ${item[index]!.length.toString()} * W: ${item[index]!.width.toString()}"),
                                          Text(
                                            "${(item[index]!.length! * item[index]!.width!).toStringAsFixed(2)} m\u00B2",
                                            style: GoogleFonts.poppins(),
                                          ),
                                        ],
                                      ),
                              ]),
                            );
                          },
                        ),
                      ),
                      10.ph
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentSummary({required ServicesModel? service}) {
    return Card(
      color: ColorManager. whiteColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Heading(
              text: 'Payment Summary',
              color: ColorManager. primaryColor,
            ),
            10.ph,
            paymentSummaryText(
                text1: 'Delievery Fees',
                text2: "${service!.deliveryFee.toString()} SAR"),
            paymentSummaryText(
                text1: 'Operation Fees',
                text2: "${service.operationFee.toString()} SAR"),
            paymentSummaryText(
                text1: 'VAT inclusive', text2: "${service.vat.toString()} SAR"),
            paymentSummaryText(
                text1: 'Order cost', text2: 'will be calculated'),
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  '500 SAR',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget paymentSummaryText({required String text1, required String text2}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            Text(
              text2,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        5.ph,
      ],
    );
  }
}
