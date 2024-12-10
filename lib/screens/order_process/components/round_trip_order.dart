import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/models/order_model.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:laundryday/constants/assets_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/order_process/components/delivery_agent_detail_card.dart';
import 'package:laundryday/screens/order_process/components/four_digit_code_widget.dart';
import 'package:laundryday/screens/order_process/components/laundry_detail_button.dart';
import 'package:laundryday/screens/order_process/components/order_id_button.dart';
import 'package:laundryday/screens/order_process/components/order_status_card.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/payment_method_nofifier.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/payment_summary_widget.dart';

class RoundTripOrder extends ConsumerWidget {
  final OrderModel orderModel;

  const RoundTripOrder({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPaymentMethod =
        ref.watch(PaymentMethodProvider).selectedPaymentMethod;
    final user = ref.read(userProvider).userModel;

    return Column(
      children: [
        10.85.ph,
        StatusImage(status: orderModel.order!.status!),
        25.ph,
        OrderStatuesCard(
          firstTripStatus: orderModel.order!.firstTripStatus,
          secondTripStatus: orderModel.order!.secondTripStatus,
          type: orderModel.order!.type!,
          status: orderModel.order!.status!,
          orderStatuses: orderModel.order!.orderStatuses!,
          countDownStart: orderModel.order?.countDownStart,
          countDownEnd: orderModel.order?.countDownEnd,
        ),
        10.ph,
        if (orderModel.order!.pickupInvoice != null) ...[
          GestureDetector(
            onTap: () {
              context.pushNamed(RouteNames.viewNetworkImage,
                  extra: Api.imageUrl +
                      orderModel.order!.pickupInvoice!.toString());
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p20,
                    top: AppPadding.p12,
                    bottom: AppPadding.p9),
                child: Row(
                  children: [
                    Text(
                      'Pickup Invoice',
                      style: getRegularStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.whiteColor),
                    ),
                    Spacer(),
                    Image.asset(
                      AssetImages.forward,
                      height: AppSize.s18,
                      color: ColorManager.whiteColor,
                    ),
                    13.pw
                  ],
                ),
              ),
              width: MediaQuery.sizeOf(context).width * 0.85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  color: ColorManager.nprimaryColor),
            ),
          ),
          10.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  21.ph,
                  PaymentSummaryText(
                      text1: 'Delivery Fee',
                      text2: (orderModel.order!.operationFee! +
                              orderModel.order!.deliveryFee!)
                          .toString()),
                  PaymentSummaryText(
                      text1: 'Item Cost',
                      text2: orderModel.order!.itemTotalPrice.toString()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: getSemiBoldStyle(
                                fontSize: 14, color: Color(0xFF818181))),
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
          ),
        
          if (orderModel.order!.paymentStatus == 'unpaid') ...[
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.ph,
                    Text(
                      'Payment Method',
                      style: getSemiBoldStyle(
                          color: ColorManager.blackColor, fontSize: 14),
                    ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
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
                                                    .read(PaymentMethodProvider
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
                                                    : const Icon(
                                                        Icons.circle_outlined),
                                                10.pw,
                                                Text(
                                                  paymentMethods[index]
                                                      .name
                                                      .toString(),
                                                  style: getSemiBoldStyle(
                                                      color: ColorManager
                                                          .blackColor,
                                                      fontSize: 14),
                                                ),
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

                          Text(
                            'Change',
                            style: getSemiBoldStyle(
                                color: ColorManager.primaryColor, fontSize: 14),
                          ),
                         
                        ],
                      ),
                    ),
                    10.ph,
                  ],
                ),
              ),
            ),
          
            selectedPaymentMethod.name == 'apple pay'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
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
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: MyButton(
                      title: 'pay',
                      onPressed: () {
                        Map data = {
                          "order_id": orderModel.order!.id,
                          "delivery_agent_id":
                              orderModel.order!.orderDeliveries!.deliveryAgentId
                        };

                        log(orderModel.order!.id.toString());

                        ref
                            .read(orderProcessProvider.notifier)
                            .paymentCollected(
                                data: data, context: context, ref: ref);
                      },
                    ),
                  )
          ]
        ],
        if (orderModel.order!.status ==
            getPickupStatus(orderStatus: OrderStatusesList.atCustomer)) ...[
          FourDigitCode(code: orderModel.order!.code!)
        ],
        10.ph,
        LaundryDetailButton(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: ColorManager.whiteColor,
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        10.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('',
                                style: getSemiBoldStyle(
                                  color: ColorManager.blackColor,
                                  fontSize: 18,
                                )),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: ColorManager.whiteColor,
                                  shape: BoxShape.circle),
                              child: IconButton(
                                  onPressed: () {
                                    GoRouter.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: ColorManager.greyColor,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          branchName: orderModel.order!.branchName!,
          totalItems: orderModel.order!.totalItems!,
        ),
        10.ph,
        OrderIdButton(orderId: orderModel.order!.id!),
        10.ph,
        if (orderModel.order?.orderDeliveries != null) ...[
          DeliveryAgentCard(
              ref: ref,
              userModel: user!,
              orderDeliveries: orderModel.order!.orderDeliveries!),
        ],
      ],
    );
  }
}
