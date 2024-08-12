import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/heading.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'Orders',
          isLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Heading(title: 'Ongoing Orders'),
            10.ph,
            ListView.separated(
              separatorBuilder: (context, index) => 10.ph,
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return _orderTile2(onTap: () {

                 

                  context.pushNamed(RouteNames().orderProcess,
                      );
                });
              },
            ),
            10.ph,
            const Heading(title: 'Order Again'),
            10.ph,
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => 10.ph,
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _orderTile(onTap: () {
                    context.pushNamed(RouteNames().orderSummary);
                  });
                },
              ),
            ),
          ]),
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
                            style: getSemiBoldStyle(color: ColorManager.blackColor,
                                fontSize: 15),
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
                                  style: getSemiBoldStyle(color: ColorManager.blackColor,
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
                                  fontSize: 14,color: ColorManager.blackColor
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'Canceled',
                            style: getSemiBoldStyle(
                                fontSize: 14,
                                color: Colors.red),
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

  Widget _orderTile2({void Function()? onTap}) {
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
                                fontSize: 15, color: ColorManager.blackColor),
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
                                      fontSize: 14,color: ColorManager.blackColor
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
                                  fontSize: 14,color: ColorManager.blackColor
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'Track Order',
                            style:getSemiBoldStyle(
                                fontSize: 14,
                                color: ColorManager.primaryColor),
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
