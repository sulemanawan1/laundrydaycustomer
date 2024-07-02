import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/service_images.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/heading.dart';

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
            const Heading(text: 'Ongoing Orders'),
            10.ph,
            ListView.separated(
              separatorBuilder: (context, index) => 10.ph,
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return _orderTile2(onTap: () {
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
                });
              },
            ),
            10.ph,
            const Heading(text: 'Order Again'),
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
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w500),
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
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500))
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
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'Canceled',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
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
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w500),
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
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500))
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
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'Track Order',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
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
