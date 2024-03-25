import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/app_services/api_services.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/service_carousel_images.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/blankets_and_linen/components/laundry_tile.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/reusable_order_now_widget.dart';

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
        LaundryTile(serviceId: widget.services!.id,),
        
    
    
      ]),
    );
  }
}

