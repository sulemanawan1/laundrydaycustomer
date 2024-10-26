import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/screens/order_process/components/delivery_agent_detail_card.dart';
import 'package:laundryday/screens/order_process/components/four_digit_code_widget.dart';
import 'package:laundryday/screens/order_process/components/laundry_detail_button.dart';
import 'package:laundryday/screens/order_process/components/order_id_button.dart';
import 'package:laundryday/screens/order_process/components/order_status_card.dart';
import 'package:laundryday/screens/order_process/components/payment_widget.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart';
import 'package:laundryday/widgets/my_button.dart';

class PickupOrder extends ConsumerWidget {
  final OrderModel orderModel;
  const PickupOrder({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider).userModel;

    return Column(
      children: [
        10.85.ph,
        StatusImage(status: orderModel.order!.status!),
        25.ph,
        OrderStatuesCard(
          type: orderModel.order!.type!,
          status: orderModel.order!.status!,
          orderStatuses: orderModel.order!.orderStatuses!,
          countDownStart: orderModel.order?.countDownStart,
          countDownEnd: orderModel.order?.countDownEnd,
        ),
        10.ph,
        if (orderModel.order!.type == 'round-trip') ...[
          if (orderModel.order!.paymentStatus == PaymentStatuses.unpaid.name &&
              orderModel.order!.status ==
                  getPickupStatus(orderStatus: OrderStatusesList.received)) ...[
            10.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyButton(
                color: ColorManager.nprimaryColor,
                title: 'Pay Now',
                onPressed: () {
                  showModalBottomSheet<void>(
                    isDismissible: false,
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    builder: (BuildContext context) {
                      return PaymentWidget(
                        orderModel: orderModel,
                      );
                    },
                  );
                },
              ),
            ),
            10.ph,
          ],
        ] else if (orderModel.order!.type == 'pickup') ...[
          if (orderModel.order!.paymentStatus ==
              PaymentStatuses.unpaid.name) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyButton(
                color: ColorManager.nprimaryColor,
                title: 'Pay Now',
                onPressed: () {
                  showModalBottomSheet<void>(
                    isDismissible: false,
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    builder: (BuildContext context) {
                      return PaymentWidget(
                        orderModel: orderModel,
                      );
                    },
                  );
                },
              ),
            )
          ]
        ],
        if (orderModel.order!.status ==
            getPickupStatus(orderStatus: OrderStatusesList.atCustomer)) ...[
          FourDigitCode(code: orderModel.order!.code!)
        ],
        LaundryDetailButton(
          branchName: orderModel.order!.branchName!,
          totalItems: orderModel.order!.totalItems!,
        ),
        10.ph,
        OrderIdButton(orderId: orderModel.order!.id!),
        15.ph,
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
