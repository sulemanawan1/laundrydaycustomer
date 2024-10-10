import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/screens/services/model/customer_order_model.dart';

class CustomerOnGoingOrderCard extends StatelessWidget {
  final List<Order> orders;

  const CustomerOnGoingOrderCard({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
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
                context.pushReplacementNamed(RouteNames.orderProcess,
                    extra: orders[index].id);
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
                        title: Text(orders[index].branchName.toString()),
                        leading: Image.asset(
                          AssetImages.laundryIcon,
                          width: 40,
                        ),
                        trailing: Text(
                          orders[index].id.toString(),
                          style: getSemiBoldStyle(
                              color: ColorManager.greyColor,
                              fontSize: FontSize.s12),
                        ),
                      ),
                      5.ph,
                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: orders[index]
                      //         .orderStatuses!
                      //         .map((e) => (e.status == 'pending' ||
                      //                     e.status == 'accepted') ||
                      //                 e.status == 'received' ||
                      //                 e.status == 'at_customer'
                      //             ? Expanded(
                      //                 flex: orders[index].status == e.status
                      //                     ? 2
                      //                     : 1,
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(
                      //                       right: AppPadding.p6),
                      //                   child: Container(
                      //                     height: 5,
                      //                     decoration: BoxDecoration(
                      //                         borderRadius:
                      //                             BorderRadius.circular(
                      //                                 AppSize.s4),
                      //                         color: orders[index].status ==
                      //                                 e.status
                      //                             ? Color(0xFF7862EB)
                      //                                 .withOpacity(0.3)
                      //                             : Color(0xFF7862EB)),
                      //                   ),
                      //                 ),
                      //               )
                      //             : Expanded(
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(
                      //                       right: AppPadding.p6),
                      //                   child: Container(
                      //                     width: 30,
                      //                     height: 5,
                      //                     decoration: BoxDecoration(
                      //                         borderRadius:
                      //                             BorderRadius.circular(
                      //                                 AppSize.s4),
                      //                         color: Color(0xFFD9D9D9)),
                      //                   ),
                      //                 ),
                      //               ))
                      //         .toList()),
                      // 5.ph,
                      Text(
                        getOrderStatusMessage(status: orders[index].status!),
                        style: getSemiBoldStyle(
                            color: ColorManager.nprimaryColor,
                            fontSize: FontSize.s12),
                      ),
                      5.ph
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

String getOrderStatusMessage({required String status}) {
  switch (status) {
    case 'pending':
      return 'Searching for Courier';
    case 'accepted':
      return 'Delivery Agent arrived to Laundry.';
    case 'received':
      return 'Delivery Agent Recived the order.';
    case 'at_customer':
      return 'Delivery Agent near you';
    case 'delivered':
      return 'Order is delivered';
    case 'canceled':
      return 'Order is canceled';
    default:
      return 'Unknown order status';
  }
}
