import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/payment_method_nofifier.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/payment_summary_widget.dart';

class PaymentWidget extends ConsumerWidget {
  final OrderModel orderModel;

  const PaymentWidget({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPaymentMethod =
        ref.watch(PaymentMethodProvider).selectedPaymentMethod;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          10.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadingMedium(title: 'Pay Now'),
              IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: ColorManager.greyColor,
                  )),
            ],
          ),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.ph,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          21.ph,
                          PaymentSummaryText(
                              text1: 'Delivery Fee',
                              text2: (orderModel.order!.operationFee! +
                                      orderModel.order!.deliveryFee!)
                                  .toStringAsFixed(2)),
                          if (orderModel.order!.additionalDeliveryFee! >
                              0.0) ...[
                            GestureDetector(
                              onTap: () {
                                Utils.showResuableBottomSheet(
                                    context: context,
                                    widget: Column(
                                      children: [
                                        orderModel.order!.items!.isNotEmpty
                                            ? ListView.builder(
                                                padding: EdgeInsets.only(
                                                    bottom: 10, top: 10),
                                                shrinkWrap: true,
                                                itemCount: orderModel
                                                    .order!.items!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  Item item = orderModel
                                                      .order!.items![index];
                                                  return ListTile(
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            style: getRegularStyle(
                                                                color: ColorManager
                                                                    .greyColor,
                                                                fontSize: 13),
                                                            '${getNote(customItemName: item.customItemName.toString())}'),
                                                        5.ph,
                                                        Text(
                                                            style: getRegularStyle(
                                                                color: ColorManager
                                                                    .blackColor,
                                                                fontSize: 14),
                                                            '${'Total Items: ${item.quantity}'}'),
                                                        5.ph,
                                                        Text(
                                                            style: getRegularStyle(
                                                                color: ColorManager
                                                                    .blackColor,
                                                                fontSize: 14),
                                                            '${'Extra Items: ${item.excessCount}'}')
                                                      ],
                                                    ),
                                                    trailing: Text(
                                                        "${item.excessDeliveryFees.toString()} SAR"),
                                                    title: Text(
                                                        "${item.customItemName.toString()}"),
                                                  );
                                                },
                                              )
                                            : Column(
                                                children: [],
                                              ),
                                      ],
                                    ),
                                    title: 'Additional Delivery Fees');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Additional Delivery Fees',
                                              style: getRegularStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF818181))),
                                          4.pw,
                                          Icon(
                                            Icons.info,
                                            size: 16,
                                            color: ColorManager.amber,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${orderModel.order!.additionalDeliveryFee} SAR ',
                                        style: getMediumStyle(
                                          color: Color(0xFF242424),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  5.ph,
                                  Divider(
                                    color: Color(0xFF818181),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          PaymentSummaryText(
                              text1: 'Item Cost',
                              text2: orderModel.order!.itemTotalPrice!
                                  .toStringAsFixed(2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',
                                  style: getSemiBoldStyle(
                                      fontSize: 14, color: Color(0xFF818181))),
                              Text(
                                '${orderModel.order!.totalPrice!.toStringAsFixed(2)} SAR',
                                style: getSemiBoldStyle(
                                  color: Color(0xFF242424),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          10.ph,
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isDismissible: false,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(AppSize.s8),
                                        topRight: Radius.circular(AppSize.s8))),
                                builder: (BuildContext context) {
                                  return ChangePaymentMethod();
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      selectedPaymentMethod.icon,
                                      height: 20,
                                    ),
                                    10.pw,
                                    HeadingMedium(
                                        title: selectedPaymentMethod.name)
                                  ],
                                ),
                                const Spacer(),
                                Heading(
                                  color: ColorManager.nprimaryColor,
                                  title: 'Change',
                                )
                              ],
                            ),
                          ),
                          10.ph
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFF9F9F9)),
                  ),
                  5.ph,
                ],
              ),
            ),
          ),
          50.ph,
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorManager.blueColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(color: ColorManager.whiteColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Image.asset(
                          selectedPaymentMethod.icon,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  10.pw,
                  Text(
                      "${orderModel.order!.totalPrice!.toStringAsFixed(2)} SAR",
                      style: getMediumStyle(
                          color: ColorManager.whiteColor,
                          fontSize: FontSize.s18))
                ],
              ),
            ),
          ),
          20.ph
        ],
      ),
    );
  }
}

class ChangePaymentMethod extends ConsumerWidget {
  const ChangePaymentMethod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethods = ref.read(PaymentMethodProvider).paymentMethods;

    final tempSelectedPaymentMethod =
        ref.watch(PaymentMethodProvider).tempSelectedPaymentMethod;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          10.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadingMedium(title: 'Choose payment method'),
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
              separatorBuilder: ((context, index) => 18.ph),
              itemCount: paymentMethods.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: ColorManager.primaryColor)),
                  child: ListTile(
                    onTap: () {
                      ref.read(PaymentMethodProvider.notifier).selectTempIndex(
                          selectedPaymentMethod: paymentMethods[index]);
                    },
                    trailing: Image.asset(
                      paymentMethods[index].icon.toString(),
                      height: 20,
                    ),
                    leading: Wrap(children: [
                      (tempSelectedPaymentMethod.name ==
                              paymentMethods[index].name)
                          ? Icon(
                              Icons.check_circle_rounded,
                              color: ColorManager.primaryColor,
                            )
                          : const Icon(Icons.circle_outlined),
                      10.pw,
                      Heading(title: paymentMethods[index].name.toString())
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.add_circle_outline),
                5.pw,
                Text(
                  'Add New Debit/Credit',
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            )),
            title: '',
            onPressed: () {
              context.pushNamed(RouteNames.addNewCard);
            },
          ),
          10.ph,
          MyButton(
            title: 'Select Method',
            onPressed: () {
              ref.read(PaymentMethodProvider.notifier).selectIndex(
                  selectedPaymentMethod: tempSelectedPaymentMethod);

              context.pop();
            },
          ),
          20.ph
        ],
      ),
    );
  }
}

String getNote({required String customItemName}) {
  switch (customItemName.toLowerCase()) {
    case 'clothes':
      return '1 SAR extra for each item if more than 7 items.';
    case 'blankets':
      return '2 SAR extra for each item if more than 2 items.';

    case 'carpets':
      return '2 SAR extra for each item if more than 2 items.';

    default:
      return 'Unknown';
  }
}
