import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/blankets_model.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/blankets_and_linen/blankets_category.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/order_review/order_review_notifier.dart';
import 'package:laundryday/screens/order_review/order_review_states.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';
import 'package:laundryday/widgets/my_heading/heading.dart';
import 'package:laundryday/widgets/payment_method_widget.dart';
import 'package:laundryday/widgets/payment_summary_widget.dart';
import 'package:collection/collection.dart';
import 'package:moyasar/moyasar.dart';

final orderReviewProvider =
    StateNotifierProvider<OrderReviewNotifier, OrderReviewStates>(
        (ref) => OrderReviewNotifier());

class OrderReview extends ConsumerStatefulWidget {
  final Arguments orderDatailsArguments;

  const OrderReview({super.key, required this.orderDatailsArguments});

  @override
  ConsumerState<OrderReview> createState() => _OrderCheckoutState();
}

class _OrderCheckoutState extends ConsumerState<OrderReview> {
  @override
  void initState() {
    super.initState();

    var subtotal = widget.orderDatailsArguments.laundryModel!.service!.deliveryFee +
        widget.orderDatailsArguments.laundryModel!.service!.operationFee;

    widget.orderDatailsArguments..laundryModel!.service!.vat = (subtotal * 15) / 100;
    ref.read(orderReviewProvider.notifier).state.total =
        subtotal + widget.orderDatailsArguments.laundryModel!.service!.vat;
  }

  Map<int?, List<LaundryItemModel>> groupItemsByCategory(
      List<LaundryItemModel> items) {
    return groupBy(items, (items) => items.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final itemsList = ref.watch(selectedItemNotifier);
    final states = ref.watch(orderReviewProvider);
    final orderItem = ref.watch(selectedDeliveryPickupItemProvider);
    Map<int?, List<LaundryItemModel>> li = groupItemsByCategory(itemsList);
    // var finalAmount = ref.watch(orderReviewProvider.notifier).state.total * 100;
    var finalAmount = ref.watch(orderReviewProvider.notifier).state.total;

    return Scaffold(
      appBar: MyAppBar(title: 'Review Order'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: LayoutBuilder(builder: (context, cx) {
          return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              widget.orderDatailsArguments.laundryModel!.type == 'deliverypickup'
                  ? SizedBox(
                      height: cx.maxHeight * 0.5,
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                5.ph,
                                const Heading(
                                  text: 'Order Details',
                                ),
                                10.ph,
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  // shrinkWrap: true,
                                  itemCount: orderItem.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      tileColor: ColorManager.mediumWhiteColor,
                                      trailing: orderItem[index].image != null
                                          ? GestureDetector(
                                              onTap: () {
                                                context.pushNamed(
                                                    RouteNames().viewImage,
                                                    extra: orderItem[index]
                                                        .image
                                                        .toString());
                                              },
                                              child: Hero(
                                                tag: 'reciept',
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.file(File(
                                                      orderItem[index]
                                                          .image
                                                          .toString())),
                                                ),
                                              ))
                                          : Text(
                                              '${orderItem[index].quantity.toString()} x'),
                                      title: Text(
                                          orderItem[index].name.toString()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: cx.maxHeight * 0.5,
                      child: ListView.builder(
                        itemCount: li.length,
                        itemBuilder: (BuildContext context, int index) {
                          int? category = li.keys.elementAt(index);

                          List<LaundryItemModel> itemsInCategory =
                              li[category]!;

                          return Column(
                            children: [
                              if (category == 1) ...[
                                GroupHeaderCard(
                                  color: Colors.blue.withOpacity(0.7),
                                  text: 'Laundry',
                                  image: 'assets/icons/laundry.png',
                                ),
                              ] else if (category == 2) ...[
                                GroupHeaderCard(
                                  color: Colors.red.withOpacity(0.7),
                                  text: 'Dry Cleaning',
                                  image: 'assets/icons/dry_cleaning.png',
                                ),
                              ] else if (category == 3) ...[
                                GroupHeaderCard(
                                  color: Colors.green.withOpacity(0.7),
                                  text: 'Pressing',
                                  image: 'assets/icons/pressing.png',
                                ),
                              ],
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: itemsInCategory.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      if (category == 1) ...[
                                        groupItemCard(
                                            color: Colors.blue.withOpacity(0.7),
                                            element: itemsInCategory[index],
                                            buttonColor: Colors.blue),
                                      ] else if (category == 2) ...[
                                        groupItemCard(
                                            color: Colors.red.withOpacity(0.7),
                                            buttonColor: Colors.red,
                                            element: itemsInCategory[index])
                                      ] else if (category == 3) ...[
                                        groupItemCard(
                                          color: Colors.green.withOpacity(0.7),
                                          element: itemsInCategory[index],
                                          buttonColor: Colors.green,
                                        )
                                      ]
                                    ],
                                  );
                                },
                              ),
                              10.ph,
                            ],
                          );
                        },
                      ),
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.ph,
                  const PaymentMethodWidget(),
                  15.ph,
                  PaymentSummaryWidget(
                    service: widget.orderDatailsArguments.laundryModel!.service,
                    ref: ref,
                  ),
                  15.ph,
                  widget.orderDatailsArguments.laundryModel!.type ==
                          'deliverypickup'
                      ? MyButton(
                          name: 'Pay ${finalAmount}',
                          onPressed: () async {
                            final paymentConfig = PaymentConfig(
                              publishableApiKey:
                                  'pk_test_zUoi76uHXmEvwcBNCqWMtdENCtTZeUZKRQM39qBT',
                              amount: finalAmount.ceil().toInt(), // SAR 257.58
                              description: 'order #1324',
                              metadata: {'size': '250g'},
                              creditCard: CreditCardConfig(
                                  saveCard: true, manual: false),
                              applePay: ApplePayConfig(
                                  merchantId: 'YOUR_MERCHANT_ID',
                                  label: 'YOUR_STORE_NAME',
                                  manual: false),
                            );

                            log(paymentConfig.toString());
                            final source = CardPaymentRequestSource(
                                creditCardData: CardFormModel(
                                  
                                    name: 'Suleman Abrar',
                                    number: '4847831061063886',
                                    month: '03',
                                    cvc: '123',
                                    year: '29'),
                                tokenizeCard: (paymentConfig.creditCard
                                        as CreditCardConfig)
                                    .saveCard,
                                manualPayment: (paymentConfig.creditCard
                                        as CreditCardConfig)
                                    .manual);

                            final paymentRequest =
                                PaymentRequest(paymentConfig, source);

                            final result = await Moyasar.pay(
                                apiKey: paymentConfig.publishableApiKey,
                                paymentRequest: paymentRequest);

                      var t=      result as ValidationError;
                      
                            log(t.errors.toString());

                            context.pushNamed(RouteNames().findCourier,extra: widget.orderDatailsArguments);

                            // ignore: use_build_context_synchronously
                            // onPaymentResult(
                            //     ref: ref, context: context, result: result);
                          },
                        )
                      // ? CreditCard(
                      //     config: PaymentConfiguration(
                      //         amount: ref
                      //             .read(orderReviewProvider.notifier)
                      //             .state
                      //             .total),
                      //     onPaymentResult: (result) {
                      //       if (result is PaymentResponse) {
                      //         switch (result.status) {
                      //           case PaymentStatus.initiated:
                      //             // handle 3DS redirection.

                      //             log(result.status.toString());
                      //             break;
                      //           case PaymentStatus.paid:
                      //             // handle success.
                      //             // states.isPaid = true;
                      //             context.pushNamed(RouteNames().findCourier);

                      //             log(result.status.toString());

                      //             break;
                      //           case PaymentStatus.failed:
                      //             // handle failure.
                      //             log(result.status.toString());

                      //             break;
                      //           case PaymentStatus.authorized:
                      //             // TODO: Handle this case.
                      //             log(result.status.toString());
                      //             break;

                      //           case PaymentStatus.captured:
                      //             log(result.status.toString());
                      //             break;

                      //           // TODO: Handle this case.
                      //         }
                      //       }
                      //     },
                      //   )

                      : MyButton(
                          name: 'Place Order',
                          onPressed: () {
                            context.pushNamed(RouteNames().findCourier,extra: widget.orderDatailsArguments);
                          },
                        ),
                  30.ph,
                ],
              )
            ]),
          );
        }),
      ),
    );
  }

  Widget groupItemCard(
      {required LaundryItemModel element,
      required Color color,
      required Color buttonColor}) {
    return Container(
      margin: EdgeInsets.zero,
      color: color,
      child: Column(
        children: [
          ListTile(
            title: Text(
              element.name.toString(),
              style: GoogleFonts.poppins(
                  color: ColorManager.whiteColor, fontWeight: FontWeight.w600),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                (element.initialCharges! *
                        int.parse(element.quantity.toString()))
                    .toString(),
                maxLines: 2,
                style: GoogleFonts.poppins(
                    color: ColorManager.whiteColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            trailing: Container(
              height: 30,
              decoration: const ShapeDecoration(
                  color: Colors.white, shape: StadiumBorder()),
              margin: EdgeInsets.zero,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    5.pw,
                    element.quantity == 1
                        ? IconButton(
                            padding: const EdgeInsets.only(left: 5),
                            constraints: const BoxConstraints(
                                minWidth: 30, maxWidth: 30),
                            onPressed: () {
                              ref
                                  .read(selectedItemNotifier.notifier)
                                  .deleteQuantity(id: element.id);
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/delete.svg',
                              height: 18,
                              color: buttonColor,
                            ))
                        : IconButton(
                            // ignore: prefer_const_constructors
                            padding: EdgeInsets.only(left: 5),
                            constraints: const BoxConstraints(
                                minWidth: 30, maxWidth: 30),
                            onPressed: () {
                              ref
                                  .read(selectedItemNotifier.notifier)
                                  .removeQuantity(id: element.id);
                            },
                            icon: Icon(
                              Icons.remove,
                              color: buttonColor,
                            )),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: 40, maxWidth: 40),
                      child: Center(
                        child: Text(
                          element.quantity.toString(),
                          style: GoogleFonts.poppins(
                              color: buttonColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    IconButton(
                        padding: const EdgeInsets.only(right: 5),
                        constraints:
                            const BoxConstraints(minWidth: 30, maxWidth: 30),
                        onPressed: () {
                          ref
                              .read(selectedItemNotifier.notifier)
                              .addQuantity(id: element.id);
                        },
                        icon: Icon(
                          Icons.add,
                          color: buttonColor,
                        )),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                ''.toString(),
                style: GoogleFonts.poppins(
                    color: ColorManager.whiteColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

PaymentConfiguration({required double amount}) {
  var finalAmount = amount * 100;

  final paymentConfig = PaymentConfig(
    publishableApiKey: 'pk_test_zUoi76uHXmEvwcBNCqWMtdENCtTZeUZKRQM39qBT',
    amount: finalAmount.ceil().toInt(), // SAR 257.58
    description: 'order #1324',
    metadata: {'size': '250g'},
    creditCard: CreditCardConfig(saveCard: true, manual: false),
    // applePay: ApplePayConfig(
    //     merchantId: 'YOUR_MERCHANT_ID',
    //     label: 'YOUR_STORE_NAME',
    //     manual: false),
  );
  return paymentConfig;
}

void onPaymentResult(
    {result, required WidgetRef ref, required BuildContext context}) {
  if (result is PaymentResponse) {
    switch (result.status) {
      case PaymentStatus.initiated:
        // handle 3DS redirection.

        log(result.status.toString());
        break;
      case PaymentStatus.paid:
        // handle success.
        // states.isPaid = true;
        context.pushNamed(RouteNames().findCourier);

        log(result.status.toString());

        break;
      case PaymentStatus.failed:
        // handle failure.
        log(result.status.toString());

        break;
      case PaymentStatus.authorized:
        // TODO: Handle this case.
        log(result.status.toString());
        break;

      case PaymentStatus.captured:
        log(result.status.toString());
        break;

      // TODO: Handle this case.
    }
  }
}

class GroupHeaderCard extends StatelessWidget {
  final Color? color;
  final String? text;
  final String? image;

  const GroupHeaderCard(
      {super.key,
      required this.color,
      required this.text,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      color: color ?? ColorManager.backgroundColor,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                text!,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: ColorManager.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                image!,
                height: 34,
                color: ColorManager.whiteColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ClothDetailsArguments {
  ServicesModel? servicesModel;
  LaundryModel? laundryModel;

  ClothDetailsArguments({
    required this.laundryModel,
    required this.servicesModel,
  });
}
