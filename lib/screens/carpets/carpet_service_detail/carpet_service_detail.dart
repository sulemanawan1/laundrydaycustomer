// ignore_for_file: must_be_immutable, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/carpet.dart';
import 'package:laundryday/models/carpet_category_laundry.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/screens/carpets/carpet_service_detail/notifier/laundry_list_notifier.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_carousel.dart';

class CarpetServiceDetail extends ConsumerStatefulWidget {
  ServicesModel? services;
  CarpetServiceDetail({super.key, required this.services});

  @override
  ConsumerState<CarpetServiceDetail> createState() => _CarpertDetailsState();
}

class _CarpertDetailsState extends ConsumerState<CarpetServiceDetail> {
  int _currentIndex = 0;
  late CarouselController controller;

  List images = [];

  @override
  void initState() {
    super.initState();

    controller = CarouselController();

    ref.read(laundryListProvider.notifier).state!.clear();

    ref.read(laundryListProvider.notifier).state!.addAll([
      CarpetCategoryLaundry(
          service: widget.services,
          lat: 23.2,
          lng: 32.5,
          rating: 4.6,
          address:
              "7000 Ash Shaikh Salih Ibn Abdul Aziz Ibn Abdul Rahman, As Suwaidi Al Gharabi, 3417, Riyadh 12993",
          userRatingTotal: 25,
          id: 1,
          name: 'Aljabr Laundry',
          placeId: "#place1",
          logo: 'assets/aljabr.png',
          distance: 1.2,
          type: 'register',
          carpets: [
            Carpet(
                id: 1,
                laundryId: 1,
                name: 'Carpet',
                image: 'assets/carpets/mats.png',
                charges: 11.5,
                quantity: 1,
                category: 'carpets',
                initialCharges: 11.5,
                length: 0.0,
                width: 0.0,
                prefixLength: 0,
                postfixLength: 0,
                prefixWidth: 0,
                postfixWidth: 0,
                size: 0.0),
            Carpet(
                id: 2,
                laundryId: 1,
                name: 'Mat',
                charges: 7,
                quantity: 1,
                image: 'assets/carpets/normal_carpet.png',
                category: 'mats',
                initialCharges: 7,
                length: 0.0,
                width: 0.0,
                prefixLength: 0,
                postfixLength: 0,
                prefixWidth: 0,
                postfixWidth: 0,
                size: 0.0)
          ]),
      CarpetCategoryLaundry(
          service: widget.services,
          lat: 24.2,
          lng: 44.5,
          rating: 4.0,
          address: "MPR5+M2J, Abu Bakr Alrazi St, As Sulimaniyah, Riyadh 12232",
          userRatingTotal: 25,
          id: 2,
          name: 'Al Rahden',
          placeId: "#place1",
          logo: 'assets/al_rahden.png',
          distance: 1.7,
          type: 'register',
          carpets: [
            Carpet(
                id: 3,
                laundryId: 2,
                name: 'Carpet',
                image: 'assets/carpets/mats.png',
                charges: 13.0,
                quantity: 1,
                category: 'carpets',
                initialCharges: 13.0,
                length: 0.0,
                width: 0.0,
                prefixLength: 0,
                postfixLength: 0,
                prefixWidth: 0,
                postfixWidth: 0,
                size: 0.0),
            Carpet(
                id: 4,
                laundryId: 2,
                name: 'Mat',
                charges: 7,
                quantity: 1,
                image: 'assets/carpets/normal_carpet.png',
                category: 'mats',
                initialCharges: 7,
                length: 0.0,
                width: 0.0,
                prefixLength: 0,
                postfixLength: 0,
                prefixWidth: 0,
                postfixWidth: 0,
                size: 0.0)
          ]),
      
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final laundries = ref.read(laundryListProvider);

    images.clear();

    images = widget.services!.images.map((e) => e.image).toList();

    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      // appBar: MyAppBar(
      //   onPressed: () {
      //     GoRouter.of(context).pushNamed(RouteNames().home);
      //   },
      //   title: widget.services!.name.toString(),
      // ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            images.isEmpty
                ? AspectRatio(
                    aspectRatio: 5 / 4,
                    child: Image.asset(widget.services!.image.toString()),
                  )
                : MyCarousel(
                    aspectRatio: 5 / 4,
                    images: images,
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
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle, color: ColorManager. whiteColor),
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
            // images.isNotEmpty
            //     ? MyCarouselIndicator(
            //                         dotCount: images.length,
            //                         position: _currentIndex,
            //                         onTap: (index) {

            //                           controller?.animateToPage(index);
            //                           setState(() {

            //                           });
            //                         },
            //       )
            //     : const SizedBox(),
          ],
        ),
        15.ph,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Heading(text: 'All Laundries'),
        ),
        15.ph,
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: laundries!.length,
            itemBuilder: (BuildContext context, int index) {
              return CarpetLaundryTile(
                  laundry: laundries[index],
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                        RouteNames().carpetsScreen,
                        extra: CarpetDetailsArguments(
                            laundry: laundries[index],
                            services: widget.services));
                  });
            },
          ),
        )
      ]),
    );
  }
}

class CarpetLaundryTile extends StatelessWidget {
  CarpetCategoryLaundry? laundry;
  void Function()? onTap;
  CarpetLaundryTile({super.key, this.laundry, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: ColorManager. whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorManager. greyColor, width: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          color: ColorManager. mediumWhiteColor),
                      child: Center(
                        child: Image.asset(
                          laundry!.logo.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 20),
                      child: Text(
                        laundry!.name.toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            4.ph,
             Divider(
              thickness: 0.2,
              color: ColorManager. blackColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.amber,
                  ),
                  5.pw,
                  Text(
                    laundry!.rating.toString(),
                    style: GoogleFonts.poppins(),
                  ),
                  10.pw,
                   Icon(
                    Icons.place,
                    size: 16,
                    color: ColorManager. primaryColor,
                  ),
                  5.pw,
                  Text(
                    "${laundry!.distance.toString()} km",
                    style: GoogleFonts.poppins(
                        color: ColorManager. greyColor, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            4.ph
          ],
        ),
      ),
    );
  }
}
class CarpetDetailsArguments {
  ServicesModel? services;
  CarpetCategoryLaundry? laundry;

  CarpetDetailsArguments({required this.laundry, required this.services});
}
