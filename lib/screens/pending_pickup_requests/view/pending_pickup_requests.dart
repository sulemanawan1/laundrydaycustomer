import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/models/order_list_model.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import '../../../constants/assets_manager.dart';

class PendingPickupRequests extends ConsumerWidget {
  final OrderListModel orderListModel;

  const PendingPickupRequests({super.key, required this.orderListModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Order> orders = orderListModel.orders!;
    return Scaffold(
      appBar: MyAppBar(
        onPressed: () {
          ref.invalidate(pendingPickupRequestProvider);

          ref.invalidate(customerOrderProvider);
          context.pop();
        },
        title: 'Pending Pickup Requests',
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        physics: NeverScrollableScrollPhysics(),
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          int orderId = orders[index].id!;

          return GestureDetector(
            onTap: () {
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
                                context.pop();
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
                                  backgroundColor: WidgetStateColor.resolveWith(
                                      (c) => ColorManager.primaryColor)),
                              onPressed: () {
                                ref
                                    .read(serviceProvider.notifier)
                                    .pickupOrderRoundTrip(
                                        data: {"id": orderId},
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

              // context.pushNamed(RouteNames.orderProcess, extra: orderId);
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
                    Text(
                      'Your Order expired  ${DateFormat('EEEE, dd MMM yyyy hh:mm:ss a').format(orders[index].pickupRequestedExpiryDate!)}',
                      style: getSemiBoldStyle(color: ColorManager.redColor),
                    ),
                    5.ph,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
