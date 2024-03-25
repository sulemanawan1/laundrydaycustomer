import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/Widgets/my_heading/heading.dart';
import 'package:laundryday/app_services/api_services.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/service_carousel_images.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/utils.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';
import 'package:laundryday/widgets/my_loader/my_loader.dart';
import 'package:laundryday/widgets/reusable_laundry_tile.dart/reuseable_laundry_tile.dart';
import 'package:laundryday/widgets/reusable_order_now_card.dart';

final laundriesApiProvider = Provider<ApiServices>((ref) => ApiServices());

final laundriesProvider =
    FutureProvider.family<List<LaundryModel>, int>((ref, serviceId) {
  return ref.read(laundriesApiProvider).getAllLaundries(serviceId: serviceId);
});

// ignore: must_be_immutable
class BlanketAndLinenServiceDetail extends ConsumerStatefulWidget {
  ServicesModel? services;

  BlanketAndLinenServiceDetail({super.key, required this.services});

  @override
  ConsumerState<BlanketAndLinenServiceDetail> createState() =>
      _BlanketAndLinenServiceDetailState();
}

class _BlanketAndLinenServiceDetailState
    extends ConsumerState<BlanketAndLinenServiceDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyAppBar(
        title: null,
        iconColor: ColorManager.purpleColor,
        backgroundColor: ColorManager.lightPurple,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        10.ph,
        ref.watch(laundriesProvider(widget.services!.id)).when(
            data: (laundries) {
            var groupedItems = groupItemsByCategory(laundries);

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppMargin.m10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: groupedItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    
                    
                        
                 String category = groupedItems.keys.elementAt(index);
                    List itemsInCategory = groupedItems[category]!;
                        
                        
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      category=='deliverypickup'?  Center(
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: const StadiumBorder(),
                        
                            
                            
                            color:    ColorManager.lightPurple                      ,
                        ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                            child: 
                            Center(
                              
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Heading(text: 'Recieving from the Laundry',color: ColorManager.purpleColor,),
                              )),
                          ),
                        ),
                      ):const SizedBox(),
                        ListView.builder(shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                          itemCount: itemsInCategory.length,
                          itemBuilder: (BuildContext context, int index) {
                            return    ResuableLaundryTile(
                              onTap: () {
                                if (itemsInCategory[index].status == 'closed') {
                                  Utils.showResuableBottomSheet(
                                      context: context,
                                      widget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          10.ph,
                                          Text(
                                            '${itemsInCategory[index].name} is currently closed.',
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          5.ph,
                                          Text(
                                            'Oops! It look like ${itemsInCategory[index].name} is taking a break right now. Please choose another laundry.',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    ColorManager.greyColor),
                                          ),
                                          10.ph,
                                          MyButton(
                                            name: 'Find another Laundry',
                                            onPressed: () {
                                              context.pop();
                                            },
                                          ),
                                          30.ph,
                                        ],
                                      ),
                                      title: 'Closed');
                                } else {
                                  if (itemsInCategory[index].type ==
                                      'deliverypickup') {
                                    GoRouter.of(context).pushNamed(
                                        RouteNames().deliveryPickup,
                                        extra: Arguments(
                                          laundryModel: itemsInCategory[index],
                                        ));
                                  } else {
                                    GoRouter.of(context).pushNamed(
                                        RouteNames().blanketsCategory,
                                        extra: itemsInCategory[index]);
                                  }
                                }
                              },
                              laundry: itemsInCategory[index],
                            )
                                             
                                              ;
                          },
                        ),
                        
                        
                     
                      ],
                    );
                  }),
            ),
          );
        }, error: (error, stackTrace) {
          return const Loader();
        }, loading: () {
          return const Loader();
        }),
      ]),
    );
  }
}

groupItemsByCategory(List<LaundryModel> items) {
  return groupBy(items, (item) => item.type);
}
