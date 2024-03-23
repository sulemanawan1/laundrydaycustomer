
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/service_carousel_images.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/services/components/address_bottom_sheet_widget.dart';
import 'package:laundryday/screens/services/components/on_going_order_list_widget.dart';
import 'package:laundryday/screens/services/components/services_grid_widget.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/screens/services/services_states.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';

final serviceProvider = StateNotifierProvider<ServicesNotifier, ServicesStates>(
    (ref) => ServicesNotifier());

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ConsumerState<Services> createState() => _ServicesState();
}

class _ServicesState extends ConsumerState<Services> {
  List<ServicesModel> services = [];
  final int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  List images = [
    'assets/carousel-1.jpg',
    'assets/carousel-2.jpg',
    'assets/carousel-3.jpg',
    'assets/carousel-4.jpg',
  ];

  @override
  void initState() {
    super.initState();

    services.add(ServicesModel(
        vat: 0.00,
        id: 1,
        name: 'Clothes',
        deliveryFee: 14.00,
        operationFee: 2.00,
        image: 'assets/services_clothing.jpg',
        images: [
          ServiceCarouselImage(image: 'assets/clothes_1.jpg'),
          ServiceCarouselImage(image: 'assets/clothes_2.jpg'),
          ServiceCarouselImage(image: 'assets/clothes_3.jpg'),
          ServiceCarouselImage(image: 'assets/clothes_4.jpg'),
          ServiceCarouselImage(image: 'assets/clothes_5.jpg'),
        ]));
    services.add(ServicesModel(
        vat: 0.00,
        id: 2,
        deliveryFee: 18.00,
        operationFee: 2.00,
        name: 'Blankets',
        image: 'assets/services_blankets.jpg',
        images: [
          ServiceCarouselImage(image: 'assets/blankets_1.jpg'),
          ServiceCarouselImage(image: 'assets/blankets_2.jpg'),
        ]));
    services.add(ServicesModel(
        vat: 0.00,
        id: 3,
        deliveryFee: 11.50,
        operationFee: 2.00,
        name: "Carpets",
        image: 'assets/services_carpets.jpeg',
        images: [
          ServiceCarouselImage(image: 'assets/carpets_1.jpg'),
          ServiceCarouselImage(image: 'assets/carpets_2.jpg'),
        ]));
    services.add(ServicesModel(
        vat: 0.0,
        id: 4,
        deliveryFee: 14.00,
        operationFee: 2.00,
        name: "Furniture",
        image: 'assets/services_furniture.jpeg',
        images: [
          ServiceCarouselImage(image: 'assets/furniture_1.jpg'),
          ServiceCarouselImage(image: 'assets/furniture_2.jpg'),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.primaryColor, size: 24),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(241, 240, 245, 1),
        leadingWidth: MediaQuery.of(context).size.width * .8,
        leading: GestureDetector(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              builder: (BuildContext context) {
                return Consumer(builder: (context, reff, child) {
                  return const AddressBottomSheetWidget();
                });
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      3.ph,
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pickup from",
                              style: GoogleFonts.poppins(
                                color: ColorManager.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Riyah,Alhazm",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: ColorManager.blackColor,
                          ),
                        ),
                      ),
                      3.ph,
                    ],
                  ),
                )),
          ),
        ),
        actions: [
          10.pw,
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Icon(
                  Icons.notifications_outlined,
                ),
              ),
            ),
          ),
          10.pw,
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: SizedBox(
            height: constraints.maxHeight,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: constraints.maxHeight * 0.3,
                child: const OnGoingOrderListWidget(),
              ),

              // MyCarousel(
              //   images: images,
              //   index: _currentIndex,
              //   carouselController: _carouselController,
              //   onPageChanged: (index, reason) {
              //     setState(() {
              //       _currentIndex = index;
              //     });
              //   },
              // ),
              // 10.ph,
              // MyCarouselIndicator(
              //   dotCount: images.length,
              //   position: _currentIndex,
              //   onTap: (int index) {

              //     // _carouselController.animateToPage(index);

              //   },
              // ),
              SizedBox(
                height: constraints.maxHeight * 0.7,
                child: ServicesGrid(
                  services: services,
                ),
              ),
            ]),
          ),
        );
      }),
    );
  }
}
