import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/app_services/api_services.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/service_carousel_images.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/blankets_and_linen/components/carpet_laundry_tile.dart';
import 'package:laundryday/screens/blankets_and_linen/components/laundry_tile.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_carousel.dart';
import 'package:laundryday/widgets/reusable_order_now_widget.dart';

final laundriesApiProvider = Provider<ApiServices>((ref) => ApiServices());

final laundriesProvider =
    FutureProvider.family<List<LaundryModel>, int>((ref, serviceId) {
  return ref.read(laundriesApiProvider).getAllLaundries(serviceId: serviceId);
});

class Laundries extends ConsumerStatefulWidget {
  ServicesModel? services;

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

    log(widget.services!.images.map((e) => e.image).toList().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.services!.id == 3
          ? null
          : MyAppBar(
              title: null,
              iconColor: ColorManager.purpleColor,
              backgroundColor: ColorManager.lightPurple,
            ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.services!.id == 3) ...[
          Stack(
            children: [
              widget.services!.images.isEmpty
                  ? AspectRatio(
                      aspectRatio: 5 / 4,
                      child: Image.asset(widget.services!.image.toString()),
                    )
                  : MyCarousel(
                      aspectRatio: 5 / 4,
                      images: widget.services!.images,
                      index: _currentIndex,
                      carouselController: controller,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
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
            child: Heading(text: 'All Laundries'),
          )
        ] else ...[
          ReusableOrderNowCard(
            onPressed: () {
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
                          ServiceCarouselImage(image: 'assets/clothes_1.jpg'),
                          ServiceCarouselImage(image: 'assets/clothes_2.jpg'),
                          ServiceCarouselImage(image: 'assets/clothes_3.jpg'),
                          ServiceCarouselImage(image: 'assets/clothes_4.jpg'),
                          ServiceCarouselImage(image: 'assets/clothes_5.jpg'),
                        ]),
                    lat: 24.2,
                    lng: 44.5,
                    rating: 3.0,
                    address:
                        "MPR5+M2J, Abu Bakr Alrazi St, As Sulimaniyah, Riyadh 12232",
                    userRatingTotal: 25,
                    id: 1,
                    name: 'Al Nayab',
                    placeId: "#place1",
                    logo: 'assets/clothing_services_icons.png',
                    distance: 2.7,
                    type: 'register',
                    banner: 'assets/category_banner/clothes_banner.jpg',
                    seviceTypes: [
                      ServiceTypesModel(
                          id: 1,
                          serviceId: 1,
                          type: 'laundry',
                          startingTime: 1,
                          endingTime: 2,
                          unit: 'Hr'),
                      ServiceTypesModel(
                          id: 2,
                          serviceId: 1,
                          type: 'drycleaning',
                          startingTime: 30,
                          endingTime: 50,
                          unit: 'Min'),
                      ServiceTypesModel(
                          id: 3,
                          serviceId: 1,
                          type: 'pressing',
                          startingTime: 1,
                          endingTime: 2,
                          unit: 'Hr'),
                    ],
                    timeslot: [
                      TimeSlot(
                          openTime: TimeOfDay(hour: 7, minute: 0),
                          closeTime: TimeOfDay(hour: 12, minute: 0),
                          weekNumber: 1),
                      TimeSlot(
                          openTime: TimeOfDay(hour: 7, minute: 0),
                          closeTime: TimeOfDay(hour: 00, minute: 00),
                          weekNumber: 2),
                      TimeSlot(
                          openTime: TimeOfDay(hour: 7, minute: 0),
                          closeTime: TimeOfDay(hour: 0, minute: 0),
                          weekNumber: 3),
                      TimeSlot(
                          openTime: TimeOfDay(hour: 7, minute: 0),
                          closeTime: TimeOfDay(hour: 0, minute: 0),
                          weekNumber: 4),
                      TimeSlot(
                          openTime: TimeOfDay(hour: 7, minute: 0),
                          closeTime: TimeOfDay(hour: 0, minute: 0),
                          weekNumber: 5),
                      TimeSlot(
                          openTime: TimeOfDay(hour: 7, minute: 0),
                          closeTime: TimeOfDay(hour: 0, minute: 0),
                          weekNumber: 6),
                      TimeSlot(
                          openTime: TimeOfDay(hour: 7, minute: 0),
                          closeTime: TimeOfDay(hour: 0, minute: 0),
                          weekNumber: 7),
                    ],
                    status: 'opened'),
              );
            },
          ),
        ],
        if (widget.services!.id == 3) ...[
          CarpetLaundryTile(
            services: widget.services,
          )
        ] else ...[
          LaundryTile(
            serviceId: widget.services!.id,
          )
        ]
      ]),
    );
  }
}
