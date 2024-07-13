import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/service_images.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/home/provider/home_notifier.dart';
import 'package:laundryday/utils/constants/colors.dart';
import 'package:laundryday/utils/constants/font_manager.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/constants/value_manager.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/circular_timer_widget.dart';
import 'package:laundryday/widgets/heading.dart';

class OnGoingOrderListWidget extends StatelessWidget {
  const OnGoingOrderListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final onGoingOrderList = ref.watch(homeProvider).onGoingOrderList;
      final onGoingOrderTimerList =
          ref.watch(homeProvider).onGoingOrderTimerList;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.ph,
          const Heading(title: 'On going order'),
          10.ph,
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: onGoingOrderList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  final LaundryModel laundryModel = LaundryModel(
                      service: ServicesModel(
                        vat: 15.0,
                        id: 1,
                        name: 'Clothes',
                        deliveryFee: 14.0,
                        operationFee: 2.0,
                        image: 'assets/services_clothing.jpg',
                        images: [
                          ServiceImage(image: 'assets/clothes_1.jpg'),
                          ServiceImage(image: 'assets/clothes_2.jpg'),
                          ServiceImage(image: 'assets/clothes_3.jpg'),
                          ServiceImage(image: 'assets/clothes_4.jpg'),
                          ServiceImage(image: 'assets/clothes_5.jpg'),
                        ],
                      ),
                      lat: 24.2,
                      lng: 44.5,
                      rating: 5.0,
                      address: "Riyadh, 12232",
                      userRatingTotal: 25,
                      id: 2,
                      name: 'Abdullah Haleem Laundrys',
                      logo: 'assets/clothing_services_icons.png',
                      distance: 2.1,
                      type: 'register',
                      banner: 'assets/category_banner/clothes_banner.jpg',
                      seviceTypes: [
                        ServiceTypesModel(
                            id: 2, serviceId: 1, type: 'drycleaning'),
                        ServiceTypesModel(
                            id: 3, serviceId: 1, type: 'pressing'),
                      ],
                      status: 'closed');

                  Arguments arguments = Arguments(laundryModel: laundryModel);

                  context.pushNamed(RouteNames().orderProcess,
                      extra: arguments);
                },
                child: SizedBox(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p10),
                      child: Column(
                        children: [
                          10.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order #7155017',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeightManager.medium,
                                    fontSize: FontSize.s14),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/open_box.png',
                                    height: 20,
                                    color: ColorManager.primaryColor,
                                  ),
                                  5.pw,
                                  // Text('Preparing'),

                                  if (onGoingOrderList[index].type ==
                                      'pickup') ...[
                                    const SizedBox()
                                  ] else ...[
                                    10.pw,
                                    (onGoingOrderTimerList![index]
                                                    .remainingTime!
                                                    .inMinutes >=
                                                0 &&
                                            onGoingOrderTimerList[index]
                                                    .remainingTime!
                                                    .inMinutes <=
                                                1440)
                                        ? CircularTimerWidget(
                                            index: index,
                                          )
                                        : const SizedBox()
                                  ],
                                ],
                              )
                            ],
                          ),
                          10.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.storefront_outlined),
                                  10.pw,
                                  Text(
                                    'Al Rahdan',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeightManager.semiBold,
                                        fontSize: FontSize.s15),
                                  )
                                ],
                              ),
                              Text('16-36 min',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeightManager.medium,
                                      fontSize: FontSize.s14))
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/icons/open_box.png',
                                  height: 20, color: ColorManager.primaryColor),
                              Image.asset(
                                'assets/icons/close_box.png',
                                height: 20,
                              ),
                              Image.asset(
                                'assets/icons/agent_with_box.png',
                                height: 20,
                              ),
                              Image.asset(
                                'assets/icons/check.png',
                                height: 20,
                              )
                            ],
                          ),
                          10.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Track Order',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeightManager.semiBold,
                                    color: ColorManager.primaryColor),
                              ),
                              Icon(Icons.navigate_next_outlined)
                            ],
                          ),
                          10.ph,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
