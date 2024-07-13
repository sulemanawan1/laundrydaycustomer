import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/app_services/api_services.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/service_images.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/laundries/components/carpet_laundry_tile.dart';
import 'package:laundryday/screens/laundries/components/laundry_tile.dart';
import 'package:laundryday/utils/constants/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_carousel.dart';
import 'package:laundryday/widgets/reusable_order_now_widget.dart';
import 'package:laundryday/screens/services/model/services_model.dart' as s;

final laundriesApiProvider = Provider<ApiServices>((ref) => ApiServices());

final laundriesProvider =
    FutureProvider.family<List<LaundryModel>, int>((ref, serviceId) {
  return ref.read(laundriesApiProvider).getAllLaundries(serviceId: serviceId);
});

class Laundries extends ConsumerStatefulWidget {
  s.Datum? services;

  Laundries({super.key, required this.services});

  @override
  ConsumerState<Laundries> createState() =>
      _BlanketAndLinenServiceDetailState();
}

class _BlanketAndLinenServiceDetailState extends ConsumerState<Laundries> {
  int _currentIndex = 0;
  late CarouselController controller;
  @override
  void initState() {
    super.initState();
    controller = CarouselController();

    // log(widget.services!.images.map((e) => e.image).toList().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.services!.serviceName == 'Carpets'
          ? null
          : MyAppBar(
              title: null,
              iconColor: ColorManager.blackColor,
              backgroundColor: ColorManager.backgroundColor,
            ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.services!.serviceName == 'Carpets') ...[
          Stack(
            children: [
              // widget.services!.images.isEmpty
              //     ? AspectRatio(
              //         aspectRatio: 5 / 4,
              //         child: Image.asset(widget.services!.image.toString()),
              //       )
              //     : MyCarousel(
              //         aspectRatio: 5 / 4,
              //         images: widget.services!.images,
              //         index: _currentIndex,
              //         carouselController: controller,
              //         onPageChanged: (index, reason) {
              //           setState(() {
              //             _currentIndex = index;
              //           });
              //         },
              //       ),
              Positioned(
                top: 40,
                left: 20,
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorManager.whiteColor),
                    child: Center(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    )),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Heading(title: 'All Laundries'),
          )
        ] else ...[
          ReusableOrderNowCard(
            image: widget.services!.serviceName == 'Clothes'
                ? "assets/order_now_clothes.jpeg"
                : "assets/order_now_blankets.jpeg",
            onPressed: () {
              if (widget.services!.serviceName == 'Clothes') {
                GoRouter.of(context).pushNamed(
                  RouteNames().blanketsCategory,
                  extra: LaundryModel(
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
                          ]),
                      lat: 24.2,
                      lng: 44.5,
                      rating: 3.0,
                      address:
                          "MPR5+M2J, Abu Bakr Alrazi St, As Sulimaniyah, Riyadh 12232",
                      userRatingTotal: 25,
                      id: 1,
                      name: 'Al Nayab',
                      logo: 'assets/clothing_services_icons.png',
                      distance: 2.7,
                      type: 'register',
                      banner: 'assets/category_banner/clothes_banner.jpg',
                      seviceTypes: [
                        ServiceTypesModel(
                          id: 1,
                          serviceId: 1,
                          type: 'laundry',
                        ),
                        ServiceTypesModel(
                          id: 2,
                          serviceId: 1,
                          type: 'drycleaning',
                        ),
                        ServiceTypesModel(
                          id: 3,
                          serviceId: 1,
                          type: 'pressing',
                        ),
                      ],
                      status: 'opened'),
                );
              } else {
                context.pushNamed(
                  RouteNames().blanketsCategory,
                  extra: LaundryModel(
                      service: ServicesModel(
                          operationFee: 2.0,
                          vat: 15.0,
                          id: 2,
                          deliveryFee: 18.0,
                          name: 'Blankets',
                          image: 'assets/services_blankets.jpg',
                          images: [
                            ServiceImage(image: 'assets/blankets_1.jpg'),
                            ServiceImage(image: 'assets/blankets_2.jpg'),
                          ]),
                      lat: 24.2,
                      lng: 44.5,
                      rating: 3.0,
                      address: "Alhazm, Riyadh 14964",
                      userRatingTotal: 25,
                      id: 1,
                      name: 'Fakhir Laundry',
                      logo: 'assets/laundry_shop.jpg',
                      banner: 'assets/blanket_and_linen_banner.jpg',
                      distance: 1.6,
                      type: 'register',
                      seviceTypes: [
                        ServiceTypesModel(id: 1, serviceId: 1, type: 'laundry'),
                      ],
                      status: 'opened'),
                );
              }
            },
          ),
        ],
        if (widget.services!.serviceName == 'Carpets') ...[
          // CarpetLaundryTile(
          //   services: widget.services,
          // )
        ] else ...[
          LaundryTile(
            serviceId: widget.services!.id!,
          )
        ]
      ]),
    );
  }
}
