import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/screens/laundries/model/google_laundry_model.dart';
import 'package:laundryday/screens/subscription_laundry/provider/subscription_laundry_notifier.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';

class SubscriptionLaundry extends ConsumerStatefulWidget {
  SubscriptionLaundry({super.key});

  @override
  ConsumerState<SubscriptionLaundry> createState() =>
      _SubscriptionLaundryState();
}

class _SubscriptionLaundryState extends ConsumerState<SubscriptionLaundry> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng? initialLatLng =
        ref.watch(subscriptionLaundryProvider).initialLatLng;
    var markers = ref.watch(subscriptionLaundryProvider).markers;
    var laundries = ref.watch(subscriptionLaundryProvider).laundries;
    var selectedBranch = ref.watch(subscriptionLaundryProvider).selectedBranch;

    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyButton(
            color: selectedBranch == null
                ? ColorManager.greyColor
                : ColorManager.primaryColor,
            title: 'Select',
            onPressed: selectedBranch == null
                ? null
                : () {
                    context.pushNamed(RouteNames.subscription);
                  }),
      ),
      appBar: MyAppBar(
        title: 'Subscription Laundry',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (address != null) ...[Text(address)],
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GoogleMap(
                    // circles: initialLatLng != null
                    //     ? {
                    //         Circle(
                    //             strokeColor: ColorManager.nprimaryColor,
                    //             strokeWidth: 1,
                    //             fillColor:
                    //                 ColorManager.nprimaryColor.withOpacity(0.2),
                    //             circleId: CircleId('branches'),
                    //             radius: 3000,
                    //             center: initialLatLng)
                    //       }
                    //     : {},
                    // polygons: district == null ? {} : polygons,
                    compassEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    trafficEnabled: true,
                    indoorViewEnabled: false,
                    markers: markers,
                    initialCameraPosition: CameraPosition(
                      target:
                          initialLatLng == null ? LatLng(0, 0) : initialLatLng,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      ref
                          .read(subscriptionLaundryProvider.notifier)
                          .mapController = controller;
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      backgroundColor: ColorManager.whiteColor,
                      onPressed: () {
                        ref
                            .read(subscriptionLaundryProvider.notifier)
                            .currentLocation();
                      },
                      child: Icon(
                        Icons.my_location,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            8.ph,
            Text(
              'Branches',
              style: getSemiBoldStyle(
                  color: ColorManager.blackColor, fontSize: FontSize.s16),
            ),
            8.ph,
            Expanded(
              flex: 2,
              child: ListView.separated(
                separatorBuilder: (context, index) => 10.ph,
                shrinkWrap: true,
                itemCount: laundries.length,
                itemBuilder: (BuildContext context, int index) {
                  GoogleLaundryModel laundry = laundries[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: selectedBranch == laundry
                            ? ColorManager.primaryColor.withOpacity(0.2)
                            : ColorManager.silverWhite,
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      onTap: () {
                        ref
                            .read(subscriptionLaundryProvider.notifier)
                            .selectedBranch(selectedBranch: laundry);
                      },
                      trailing: laundry.rating == null
                          ? null
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                10.ph,
                                Wrap(
                                  spacing: 4,
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: ColorManager.amber,
                                    ),
                                    Text(laundry.rating.toStringAsFixed(1)),
                                  ],
                                ),
                                8.ph,
                                Text(
                                    style: getRegularStyle(
                                        fontSize: FontSize.s12,
                                        color: ColorManager.greyColor),
                                    '${ref.read(subscriptionLaundryProvider.notifier).calculateDistance(initialLatLng!.latitude, initialLatLng.longitude, laundry.lat, laundry.lng).toStringAsFixed(2)} KM'),
                              ],
                            ),
                      subtitle: Text(laundry.vicinity),
                      title: Text(laundry.name),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
