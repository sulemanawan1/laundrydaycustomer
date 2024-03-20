import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/Widgets/my_heading/heading.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/service_carousel_images.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/blankets_and_linen/blankets_category.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/services/services_notifier.dart';
import 'package:laundryday/screens/services/services_states.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/font_manager.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';

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
    final states = ref.watch(serviceProvider);
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
                  final selectedIndex = reff.watch(serviceProvider);
                  return selectAdressModalBottomSheet(
                      context: context,
                      states: states,
                      selectedIndex: selectedIndex,
                      reff: reff);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            20.ph,

            const Heading(text: 'On going order'),
            10.ph,
            ListView.builder(shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){

                    final LaundryModel laundryModel = LaundryModel(
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
                          ],
                        ),
                        lat: 24.2,
                        lng: 44.5,
                        rating: 5.0,
                        address: "Riyadh, 12232",
                        userRatingTotal: 25,
                        id: 2,
                        name: 'Abdullah Haleem Laundrys',
                        placeId: "#place1",
                        logo: 'assets/clothing_services_icons.png',
                        distance: 2.1,
                        type: 'register',
                        banner: 'assets/category_banner/clothes_banner.jpg',
                        categories: [
                          ServiceTypesModel(
                              id: 2, serviceId: 1, type: 'drycleaning'),
                          ServiceTypesModel(
                              id: 3, serviceId: 1, type: 'pressing'),
                        ],
                        timeslot: [
                          TimeSlot(
                              openTime: TimeOfDay(hour: 7, minute: 0),
                              closeTime: TimeOfDay(hour: 0, minute: 0),
                              weekNumber: 1),
                          TimeSlot(
                              openTime: TimeOfDay(hour: 7, minute: 0),
                              closeTime: TimeOfDay(hour: 0, minute: 0),
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
                        status: 'closed');

                    Arguments arguments = Arguments(laundryModel: laundryModel);

                    context.pushNamed(RouteNames().orderProcess,
                        extra: arguments);
                  },
                  child: SizedBox(
                                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                    child: Column(
                      children: [
                        10.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text('Order #7155017',style: GoogleFonts.poppins(
                                  fontWeight: FontWeightManager.medium,
                                  fontSize: FontSize.s14),),
                            Row(
                              children: [
                                                              Image.asset('assets/icons/open_box.png',height: 20,color: ColorManager.primaryColor,),5.pw,
                  
                                Text('Preparing'),
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
                                Text('Al Rahdan',style: GoogleFonts.poppins(fontWeight:FontWeightManager.semiBold,fontSize:FontSize.s15),)
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
                    
                            Image.asset('assets/icons/open_box.png',height: 20,color:ColorManager.primaryColor),
                            Image.asset('assets/icons/close_box.png',height: 20,),
                            Image.asset('assets/icons/agent_with_box.png',height: 20,),
                            Image.asset('assets/icons/check.png',height: 20,)
                    
                    
                          ],
                        ),10.ph,
                         Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                          children: [
                            Text('Track Order',style: GoogleFonts.poppins(
                              fontWeight:FontWeightManager.semiBold,
                              color:ColorManager.primaryColor
                              
                  
                  
                            ),),Icon(Icons.navigate_next_outlined)
                          ],
                        ),
                        10.ph,
                      ],
                    ),
                  ),
                                ),
                              ),
                )
           ;
              },
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
            20.ph,
            ServicesGrid(
              services: services,
              states: states,
            ),
          ]),
        ),
      ),
    );
  }
}

Widget selectAdressModalBottomSheet({
  required BuildContext context,
  required ServicesStates states,
  required ServicesStates selectedIndex,
  required WidgetRef reff,
  ServicesModel? servicesModel,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        10.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Heading(text: 'Choose from saved addresses'),
            IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: ColorManager.greyColor,
                ))
          ],
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: ((context, index) => 18.ph),
            itemCount: states.address.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: (selectedIndex.addressSelectedIndex == index)
                            ? ColorManager.primaryColor
                            : ColorManager.greyColor)),
                child: ListTile(
                  tileColor: (selectedIndex.addressSelectedIndex == index)
                      ? ColorManager.primaryColorOpacity10
                      : null,
                  title: Text(states.address[index].name.toString()),
                  subtitle: Text(states.address[index].address.toString()),
                  onTap: () {
                    reff
                        .read(serviceProvider.notifier)
                        .selectIndex(index: index);

                    if (servicesModel?.name.toString() == 'Blankets') {
                      log(servicesModel!.deliveryFee.toString());

                      reff.read(selectedItemNotifier.notifier).state.clear();

                      GoRouter.of(context).pushNamed(
                          RouteNames().blanketAndLinenServiceDetail,
                          extra: servicesModel);

                      context.pop();
                    } else if (servicesModel?.name.toString() == "Carpets") {
                      print(servicesModel!.deliveryFee);
                      GoRouter.of(context).pushNamed(RouteNames().serviceDetail,
                          extra: servicesModel);

                      context.pop();
                    } else if (servicesModel?.name.toString() == "Clothes") {
                      log(servicesModel!.id.toString());
                      log(servicesModel.deliveryFee.toString());

                      reff.read(selectedItemNotifier.notifier).state.clear();

                      GoRouter.of(context).pushNamed(
                          RouteNames().blanketAndLinenServiceDetail,
                          extra: servicesModel);
                      context.pop();
                    }
                  },
                  leading: (selectedIndex.addressSelectedIndex == index)
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: ColorManager.primaryColor,
                        )
                      : const Icon(Icons.circle_outlined),
                ),
              );
            },
          ),
        ),
        5.ph,
        MyButton(
          name: 'Add Address',
          isBorderButton: true,
          onPressed: () {
            context.pushNamed(RouteNames().addNewAddress);

            context.pop();
          },
        ),
        20.ph
      ],
    ),
  );
}

// ignore: must_be_immutable
class ServicesGrid extends StatelessWidget {
  final List<ServicesModel> services;
  ServicesStates states;

  ServicesGrid({super.key, required this.services, required this.states});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraint) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
            mainAxisExtent: 220),
        itemCount: services.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                builder: (BuildContext context) {
                  return Consumer(builder: (context, reff, child) {
                    final selectedIndex = reff.watch(serviceProvider);
                    return selectAdressModalBottomSheet(
                        context: context,
                        states: states,
                        selectedIndex: selectedIndex,
                        reff: reff,
                        servicesModel: services[index]);
                  });
                },
              );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  GridTile(
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        child: Image.asset(
                          width: double.infinity,
                          height: 155,
                          services[index].image.toString(),
                          fit: BoxFit.cover,
                        )),
                  ),
                  14.ph,
                  Text(
                    services[index].name.toString(),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 18),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
