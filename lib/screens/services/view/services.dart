import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/services/components/address_bottom_sheet_widget.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/screens/services/provider/services_states.dart';
import 'package:laundryday/core/constants/api_routes.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;
import 'package:laundryday/core/constants/value_manager.dart';
import 'package:laundryday/core/theme/styles_manager.dart';
import 'package:shimmer/shimmer.dart';

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
    // ref.read(homeProvider.notifier).startOnGoingOrderTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllServicesState? services = ref.watch(serviceProvider).allServicesState;
    final customerId = ref.read(userProvider).userModel!.user!.id;
    LatLng? latLng = ref.watch(addressProvider).latLng;

    String? district = ref.watch(addressProvider).district;

    myaddressmodel.Address? selectedAddress =
        ref.watch(selectedAddressProvider);

    final serviceAddress = ref.read(addressProvider.notifier);

    log("User Id $customerId");

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.primaryColor, size: 24),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(241, 240, 245, 1),
        leadingWidth: MediaQuery.of(context).size.width * .8,
        leading: GestureDetector(
          onTap: () {
            // serviceAddress.getAddress();
            serviceAddress.allAddresses(customerId: customerId!);
            showModalBottomSheet<void>(
              useSafeArea: true,
              isDismissible: false,
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
                            Text("Pickup from",
                                style: getMediumStyle(
                                    color: ColorManager.blackColor)),
                            const Icon(
                              Icons.keyboard_arrow_down,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          selectedAddress?.addressName == 'my-current-address'
                              ? 'Current Location'
                              : selectedAddress?.googleMapAddress ??
                                  "Current Location",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: selectedAddress?.addressName ==
                                    'my-current-address'
                                ? ColorManager.amber
                                : ColorManager.blackColor,
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
              if (services is AllServicesInitialState) ...[
                ServiceShimmerEffect()
              ] else if (services is AllServicesLoadingState) ...[
                ServiceShimmerEffect()
              ] else if (services is AllServicesErrorState) ...[
                ServiceShimmerEffect()
              ] else if (services is AllServicesLoadedState) ...[
                Padding(
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
                    itemCount: services.serviceModel.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // serviceAddress.getAddress();

                          serviceAddress.allAddresses(customerId: customerId!);

                          // log("Latitude ${latLng!.latitude.toString()}");
                          // log("Longitude ${latLng.longitude.toString()}");
                          // log("District ${district.toString()}");

                          showModalBottomSheet<void>(
                            isDismissible: false,
                            useSafeArea: true,
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            builder: (BuildContext context) {
                              return AddressBottomSheetWidget(
                                servicesModel:
                                    services.serviceModel.data![index],
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
                                      "${Api.imageUrl}${services.serviceModel.data![index].serviceImage.toString()}"
                                          .toString(),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              14.ph,
                              Text(
                                services.serviceModel.data![index].serviceName
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 18),
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
              ] else ...[
                ServiceShimmerEffect()
              ]
            ])),
      ),
    );
  }
}

class ServiceShimmerEffect extends StatelessWidget {
  const ServiceShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
            mainAxisExtent: 220),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  GridTile(
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          child: SizedBox())),
                  14.ph,
                  SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
