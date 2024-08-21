import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/core/widgets/payment_summary_widget.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/payment_method_nofifier.dart';
import '../order_review/data/models/order_model.dart';

class OrderCheckout extends ConsumerWidget {
  final OrderModel orderModel;
  OrderCheckout({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPaymentMethod =
        ref.watch(PaymentMethodProvider).selectedPaymentMethod;
    return Scaffold(
      appBar: MyAppBar(
        title: 'Checkout',
        actions: [
          InkWell(
            onTap: () {
              context.pushNamed(RouteNames.invoice);
            },
            child: Row(
              children: [
                const Icon(Icons.receipt),
                Text(
                  'Invoice',
                  style: getRegularStyle(color: ColorManager.primaryColor),
                )
              ],
            ),
          ),
          10.pw,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Heading(title: "Order Details"),
                      10.ph,
                      
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            21.ph,
                            PaymentSummaryText(
                                text1: 'Delivery Fee',
                                text2:
                                    orderModel.order!.deliveryFee.toString()),
                            PaymentSummaryText(
                                text1: 'Operation Fee',
                                text2:
                                    orderModel.order!.operationFee.toString()),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 23),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total',
                                      style: getSemiBoldStyle(
                                          fontSize: 14,
                                          color: Color(0xFF818181))),
                                  Text(
                                    '${orderModel.order!.totalPrice.toString()} SAR',
                                    style: getSemiBoldStyle(
                                      color: Color(0xFF242424),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            21.ph,
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFF9F9F9)),
                      ),
                      5.ph,
                      const Heading(title: "Payment Method"),
                      10.ph,
                      InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            isDismissible: false,
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            builder: (BuildContext context) {
                              return Consumer(builder: (context, reff, child) {
                                final paymentMethods = reff
                                    .read(PaymentMethodProvider)
                                    .paymentMethods;
                                final selectedPaymentMethod = reff
                                    .watch(PaymentMethodProvider)
                                    .selectedPaymentMethod;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      10.ph,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          HeadingMedium(
                                              title: 'Choose payment method'),
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
                                      Expanded(
                                        child: ListView.separated(
                                          separatorBuilder: ((context, index) =>
                                              18.ph),
                                          itemCount: paymentMethods.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            print(
                                                "Selected ${selectedPaymentMethod.name}");
                                            print(
                                                "List ${paymentMethods[index].name}");
                                            return Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .primaryColor)),
                                              child: ListTile(
                                                onTap: () {
                                                  reff
                                                      .read(
                                                          PaymentMethodProvider
                                                              .notifier)
                                                      .selectIndex(
                                                          selectedPaymentMethod:
                                                              paymentMethods[
                                                                  index]);
                                                },
                                                trailing: Image.asset(
                                                  paymentMethods[index]
                                                      .icon
                                                      .toString(),
                                                  height: 20,
                                                ),
                                                leading: Wrap(children: [
                                                  (selectedPaymentMethod.name ==
                                                          paymentMethods[index]
                                                              .name)
                                                      ? Icon(
                                                          Icons
                                                              .check_circle_rounded,
                                                          color: ColorManager
                                                              .primaryColor,
                                                        )
                                                      : const Icon(Icons
                                                          .circle_outlined),
                                                  10.pw,
                                                  Heading(
                                                      title:
                                                          paymentMethods[index]
                                                              .name
                                                              .toString())
                                                ]),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      5.ph,
                                      MyButton(
                                        isBorderButton: true,
                                        widget: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                                Icons.add_circle_outline),
                                            5.pw,
                                            Text(
                                              'Add New Debit/Credit',
                                              style: getSemiBoldStyle(
                                                color:
                                                    ColorManager.primaryColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        )),
                                        title: '',
                                        onPressed: () {
                                          context
                                              .pushNamed(RouteNames.addNewCard);
                                        },
                                      ),
                                      10.ph,
                                      MyButton(
                                        title: 'Select Method',
                                        onPressed: () {
                                          context.pop();
                                        },
                                      ),
                                      20.ph
                                    ],
                                  ),
                                );
                              });
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  selectedPaymentMethod.icon,
                                  width: 50,
                                  height: 20,
                                ),
                                10.pw,
                                HeadingMedium(title: selectedPaymentMethod.name)
                              ],
                            ),
                            const Spacer(),
                            Heading(
                              color: ColorManager.primaryColor,
                              title: 'Change',
                            )
                          ],
                        ),
                      ),
                      10.ph,
                    ],
                  ),
                ),
              ),
              70.ph,
              selectedPaymentMethod.name == 'apple pay'
                  ? InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: ColorManager.blackColor,
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Pay with',
                              style: getSemiBoldStyle(
                                color: ColorManager.whiteColor,
                                fontSize: 14,
                              ),
                            ),
                            5.pw,
                            Image.asset(
                              'assets/icons/apple_pay.png',
                              color: ColorManager.whiteColor,
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    )
                  : MyButton(
                      title: 'pay',
                      onPressed: () {},
                    )
            ],
          ),
        ),
      ),
    );
  }
}
