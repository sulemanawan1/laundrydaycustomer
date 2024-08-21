import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/resources/assets_manager.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/font_manager.dart';
import 'package:laundryday/config/resources/order_status_helper.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/screens/services/model/customer_order_model.dart';

class Orders extends ConsumerWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Order> orders = ref.watch(serviceProvider).order;

    return Scaffold(
        appBar: MyAppBar(
          title: 'Orders',
          isLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Heading(title: 'Ongoing Orders'),
              10.ph,
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: orders[index]
                                    .orderStatuses!
                                    .map((e) => (e.status == 'pending' ||
                                                e.status == 'accepted') ||
                                            e.status == 'received' ||
                                            e.status == 'at_customer'
                                        ? Expanded(
                                            flex:
                                                orders[index].status == e.status
                                                    ? 2
                                                    : 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: AppPadding.p6),
                                              child: Container(
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s4),
                                                    color: orders[index]
                                                                .status ==
                                                            e.status
                                                        ? Color(0xFF7862EB)
                                                            .withOpacity(0.3)
                                                        : Color(0xFF7862EB)),
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: AppPadding.p6),
                                              child: Container(
                                                width: 30,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s4),
                                                    color: Color(0xFFD9D9D9)),
                                              ),
                                            ),
                                          ))
                                    .toList()),
                            5.ph,
                            Text(
                              OrderStatusHelper.getOrderStatusMessage(
                                  status: orders[index].status!),
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
              10.ph,
              const Heading(title: 'Order Again'),
              10.ph,
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => 10.ph,
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _orderTile(onTap: () {
                    context.pushNamed(RouteNames.orderSummary);
                  });
                },
              ),
            ]),
          ),
        ));
  }

  Widget _orderTile({void Function()? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                  border: Border.all(width: 0.3, color: ColorManager.greyColor),
                  shape: BoxShape.rectangle),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/al_rahden.png',
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      5.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Al Rahdan',
                            style: getSemiBoldStyle(
                                color: ColorManager.blackColor, fontSize: 15),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              5.pw,
                              Text('5',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.blackColor,
                                    fontSize: 14,
                                  ))
                            ],
                          )
                        ],
                      ),
                      10.ph,
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_rounded,
                                color: ColorManager.greyColor,
                                size: 14,
                              ),
                              5.pw,
                              Text(
                                '2024/02/13',
                                style: getRegularStyle(
                                    fontSize: 14,
                                    color: ColorManager.blackColor),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'Canceled',
                            style: getSemiBoldStyle(
                                fontSize: 14, color: Colors.red),
                          ),
                          5.pw,
                        ],
                      ),
                    ],
                  ),
                ))
          ]),
        ),
      ),
    );
  }

 

}
