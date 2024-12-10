import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/constants/assets_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/models/order_list_model.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

class CustomerOnGoingOrderCard extends ConsumerWidget {
  final List<Order> orders;

  const CustomerOnGoingOrderCard({super.key, required this.orders});

  String? calculateHoursLeft(DateTime endTime) {
    DateTime now = DateTime.now();
    Duration difference = endTime.difference(now);

    if (difference.inHours == 0) {
      return null;
    }
    // Return the number of hours left
    return "${difference.inHours.toString()}:${difference.inMinutes.toString()}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (orders.isNotEmpty) ...[
          15.ph,
          Text(
            'On Going Order',
            style: getSemiBoldStyle(
                color: ColorManager.blackColor, fontSize: FontSize.s14),
          ),
          15.ph,
        ],
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: orders.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                if (orders[index].status ==
                    getRoundTripStatus(
                        orderStatus: OrderStatusesList.readyForDelivery)) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  icon: Icon(Icons.close)),
                            ),
                            Image.asset(
                              AssetImages.check,
                              height: 80,
                            ),
                            10.ph,
                            Text(
                              textAlign: TextAlign.center,
                              'Your order is ready. Would you like to receive it now?',
                              style: getMediumStyle(
                                  fontSize: FontSize.s16,
                                  color: ColorManager.blackColor),
                            ),
                            Center(
                              child: OutlinedButton(
                                  onPressed: () {
                                    context.pushNamed(RouteNames.orderProcess,
                                        extra: orders[index].id);
                                  },
                                  child: Text(
                                    'Order Details',
                                    style: getMediumStyle(
                                        color: ColorManager.primaryColor),
                                  )),
                            ),
                            25.ph,
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateColor.resolveWith(
                                              (c) => ColorManager.lightGrey)),
                                  onPressed: () {
                                    ref
                                        .read(serviceProvider.notifier)
                                        .pickupRequestUpdate(
                                            data: {"id": orders[index].id},
                                            ref: ref,
                                            context: context);
                                  },
                                  child: Text(
                                    'I will Order Later.',
                                    style: getRegularStyle(
                                        fontSize: 14,
                                        color: ColorManager.blackColor),
                                  )),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateColor.resolveWith((c) =>
                                              ColorManager.primaryColor)),
                                  onPressed: () {
                                    ref
                                        .read(serviceProvider.notifier)
                                        .pickupOrderRoundTrip(
                                            data: {"id": orders[index].id},
                                            ref: ref,
                                            context: context);
                                  },
                                  child: Text(
                                    'Order Now',
                                    style: getRegularStyle(
                                        fontSize: 14,
                                        color: ColorManager.whiteColor),
                                  )),
                            ),
                          
                          ],
                        ),
                      ),
                    ),
                  );
                
                } else {
                  context.pushNamed(RouteNames.orderProcess,
                      extra: orders[index].id);
                }
              },
              child: Card(
                color: ColorManager.silverWhite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.ph,
                      ListTile(
                        title: Text(
                          orders[index].branchName.toString(),
                          style: getSemiBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s14),
                        ),
                        leading: Image.asset(
                          AssetImages.laundryIcon,
                          width: 40,
                        ),
                        trailing: Text(
                          orders[index].id.toString(),
                          style: getSemiBoldStyle(
                              color: ColorManager.greyColor,
                              fontSize: FontSize.s14),
                        ),
                      ),
                      5.ph,
                      Text(
                        orders[index].type == 'round-trip'
                            ? getRoundTripOrderStatusMessage(
                                status: orders[index].status!)
                            : getOrderStatusMessage(
                                status: orders[index].status!),
                        style: getSemiBoldStyle(
                            color: ColorManager.nprimaryColor,
                            fontSize: FontSize.s14),
                      ),
                      5.ph,
                      if (orders[index].countDownEnd != null &&
                          (orders[index].status == 'delivering-to-store')) ...[
                        5.ph,
                        Text(
                          'Order Delivery After  ${DateFormat('EEEE, dd MMM yyyy hh:mm:ss a').format(orders[index].countDownEnd!)}',
                          style:
                              getSemiBoldStyle(color: ColorManager.blackColor),
                        ),
                        5.ph,
                      ]
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
