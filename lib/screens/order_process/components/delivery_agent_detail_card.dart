import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/resources/assets_manager.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/font_manager.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart'
    as ordermodel;
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils.dart';
class DeliveryAgentCard extends StatelessWidget {
  final ordermodel.OrderDeliveries orderDeliveries;

  DeliveryAgentCard({
    super.key,
    required this.orderDeliveries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                22.ph,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          14.pw,
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AssetImages.user)),
                                color: ColorManager.nprimaryColor,
                                shape: BoxShape.circle),
                          ),
                          14.pw,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${orderDeliveries.user?.firstName}${orderDeliveries.user?.lastName}",
                                style: getRegularStyle(
                                    color: Color(0xFF242E42),
                                    fontSize: FontSize.s17),
                              ),
                              7.ph,
                              Row(
                                children: [
                                  Image.asset(width: 16, AssetImages.rating),
                                  5.pw,
                                  Text(
                                    "4.2",
                                    style: getRegularStyle(
                                        color: Color(0xFFC8C7CC),
                                        fontSize: FontSize.s15),
                                  ),
                                ],
                              ),
                              10.ph,
                              Text("Delivery Agent",
                                  style: getMediumStyle(
                                      color: Color(0xFF242E42),
                                      fontSize: FontSize.s14)),
                              10.ph,
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                context.pushNamed(RouteNames.orderChat);
                              },
                              child: Image.asset(width: 40, AssetImages.chat)),
                          16.pw,
                          GestureDetector(
                              onTap: () async {
                                var uri = Uri.parse(
                                    "tel://${orderDeliveries.deliveryAgent!.mobileNumber}");

                                try {
                                  await launchUrl(uri);

                                  // ignore: use_build_context_synchronously
                                  context.pop();
                                } catch (e) {
                                  Utils.showToast(
                                      msg: e.toString(), isNegative: true);
                                }
                              },
                              child: Image.asset(width: 40, AssetImages.call)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s8),
                topRight: Radius.circular(AppSize.s8),
              ),
            ),
          ),
          23.ph,
          Row(
            children: [
              29.05.pw,
              Image.asset(width: AppSize.s50, AssetImages.car),
              27.4.pw,
              SizedBox(
                width: 180,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "2012 honda civic",
                  style: getRegularStyle(
                      color: Color(0xFF242E42), fontSize: FontSize.s16),
                ),
              ),
              Spacer(),
              Text(
                "9195",
                style: getRegularStyle(
                    color: Color(0xFF242E42), fontSize: FontSize.s16),
              ),
              30.05.pw
            ],
          ),
          25.96.ph
        ],
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 4,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(AppSize.s8), color: Colors.white),
    );
  }
}