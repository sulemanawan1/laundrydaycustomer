import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/home/provider/home_notifier.dart';
import 'package:laundryday/screens/home/provider/home_states.dart';
import 'package:laundryday/screens/services/components/address_bottom_sheet_widget.dart';
import 'package:laundryday/screens/services/components/on_going_order_list_widget.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/utils/api_routes.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ConsumerState<Services> createState() => _ServicesState();
}

class _ServicesState extends ConsumerState<Services> {
  List images = [
    'assets/carousel-1.jpg',
    'assets/carousel-2.jpg',
    'assets/carousel-3.jpg',
    'assets/carousel-4.jpg',
  ];

  @override
  void initState() {
    ref.read(homeProvider.notifier).startOnGoingOrderTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(serviceProvider).services;
    final customerId = ref.read(userProvider).userModel!.user!.id;

    final appstates = ref.watch(serviceProvider).appstates;
    myaddressmodel.Address? selectedAddress =
        ref.watch(selectedAddressProvider);

    final serviceAddress = ref.read(serviceAddressesProvider.notifier);

    log("User Id $customerId");

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.primaryColor, size: 24),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(241, 240, 245, 1),
        leadingWidth: MediaQuery.of(context).size.width * .8,
        leading: GestureDetector(
          onTap: () {
            serviceAddress.allAddresses(customerId: customerId!);
            showModalBottomSheet<void>(
              useSafeArea: true,
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              builder: (BuildContext context) {
                return const AddressBottomSheetWidget();
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
                          selectedAddress?.googleMapAddress ??
                              "Current Location",
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const OnGoingOrderListWidget(),
              // Column(
              //   children: [
              //     10.ph,
              //     Card(
              //       color: Colors.transparent,
              //       elevation: 0,
              //       child: CarouselSlider(
              //         carouselController: _carouselController,
              //         items: images
              //             .map((e) => ClipRRect(
              //                   borderRadius: BorderRadius.circular(8),
              //                   child: Image.asset(
              //                     e.toString(),
              //                     fit: BoxFit.cover,
              //                     width: double.infinity,
              //                   ),
              //                 ))
              //             .toList(),
              //         options: CarouselOptions(
              //           padEnds: true,
              //           viewportFraction: 1,
              //           aspectRatio: 16 / 6,
              //           enableInfiniteScroll: true,
              //           autoPlay: true,
              //           animateToClosest: true,
              //           autoPlayInterval: const Duration(seconds: 2),

              //           // autoPlayAnimationDuration: const Duration(milliseconds: 50),
              //           autoPlayCurve: Curves.linear,
              //           enlargeCenterPage: true,
              //           onPageChanged: (index, reason) {
              //             setState(() {
              //               _currentIndex = index;
              //             });
              //           },
              //         ),
              //       ),
              //     ),
              //     10.ph,
              //     MyCarouselIndicator(
              //       dotCount: images.length,
              //       position: _currentIndex,
              //       onTap: (int index) {
              //         // _carouselController.animateToPage(index);
              //       },
              //     ),
              //   ],
              // ),

              appstates == AppStates.loaded
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0,
                                mainAxisExtent: 220),
                        itemCount: services!.data!.length,
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
                                  return AddressBottomSheetWidget(
                                    servicesModel: services.data![index],
                                  );
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
                                        child: Image.network(
                                          width: double.infinity,
                                          height: 155,
                                          "${Api.imageUrl}${services.data![index].serviceImage.toString()}"
                                              .toString(),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  14.ph,
                                  Text(
                                    services.data![index].serviceName
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(child: CircularProgressIndicator())
            ])),
      ),
    );
  }
}
