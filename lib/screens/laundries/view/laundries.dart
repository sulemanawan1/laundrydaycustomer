import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/screens/laundries/components/delivery_pickup_heading.dart';
import 'package:laundryday/screens/laundries/components/service_timing_dialog.dart';
import 'package:laundryday/screens/laundries/model/google_laundry_model.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/widgets/reusable_order_now_widget.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;
import 'package:laundryday/screens/laundries/model/laundry_by_area.model.dart'
    as laundrybyareamodel;
import 'package:laundryday/widgets/reuseable_laundry_tile.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

enum ServiceTypes { clothes, carpets, blankets, furniture }

class Laundries extends ConsumerStatefulWidget {
  Laundries({
    super.key,
  });

  @override
  ConsumerState<Laundries> createState() => _LaundriesState();
}

class _LaundriesState extends ConsumerState<Laundries> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final servicemodel.Datum? selectedService =
        ref.watch(serviceProvider).selectedService;
    double screenWidth = MediaQuery.of(context).size.width;
    final aljabrAndAlrahdenLaundries =
        ref.watch(aljabrAndAlrahdenLaundryProvider);
    final pickupLaundires = ref.watch(pickupLaundriesProvider);
    final selectedAddress = ref.watch(selectedAddressProvider);
    final branchbyArea = ref.watch(branchbyAreaProvider);
    return Scaffold(
      appBar: MyAppBar(
        title: selectedService?.serviceName.toString(),
        iconColor: ColorManager.blackColor,
        backgroundColor: ColorManager.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (selectedService?.serviceName?.toLowerCase() == 'carpets') ...[
            25.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16), // Circular shape
                  child: Image.asset(
                    width: screenWidth,
                    AssetImages.carpet,
                    height: 199, // Replace with your image path
                    fit: BoxFit.fill, // Ensures the image covers the area
                  ),
                ),
              ),
            ),
            20.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      7.ph,
                      Container(
                        decoration: BoxDecoration(
                            color: ColorManager.whiteColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 6, bottom: 6, left: 9, right: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AssetImages.noteIcon,
                                height: 8,
                              ),
                              7.pw,
                              Text(
                                'Note',
                                style: getMediumStyle(color: Color(0xFFCC4142)),
                              )
                            ],
                          ),
                        ),
                      ),
                      5.ph,
                      Text(
                        'The service time for this is 4 days, and the carpet size should be 3 meters or less.',
                        style: getRegularStyle(
                            color: ColorManager.blackColor, fontSize: 12),
                      ),
                      7.ph,
                    ],
                  ),
                ),
                width: screenWidth,
                decoration: BoxDecoration(
                    color: Color(0xFFFFEEEE),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            20.ph,
            Padding(
              padding: const EdgeInsets.only(left: 29),
              child: Text(
                'Laundries',
                style: getSemiBoldStyle(
                    color: ColorManager.blackColor, fontSize: FontSize.s20),
              ),
            ),
            19.74.ph,
            aljabrAndAlrahdenLaundries.when(data: (data) {
              return data.fold((l) {
                return Text(l.toString());
              }, (r) {
                return ListView.separated(
                  separatorBuilder: (context, index) => 20.ph,
                  padding: EdgeInsets.symmetric(horizontal: 29),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: r.length,
                  itemBuilder: (BuildContext context, int index) {
                    GoogleLaundryModel laundry = r[index];

                    return GestureDetector(
                      onTap: () async {
                        ref
                            .read(laundriessProvider.notifier)
                            .selectedLaundry(selectedLaundry: laundry);

                        bool isAvailable = await ref
                            .read(laundriessProvider.notifier)
                            .nearByAgents(
                                latitude: selectedAddress!.lat!,
                                longitude: selectedAddress.lng!,
                                ref: ref,
                                context: context);

                        if (isAvailable) {
                          showDialog<void>(
                              useSafeArea: true,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    insetPadding: const EdgeInsets.all(10),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    title: Center(
                                      child: Heading(
                                        title: 'Select Service Type',
                                      ),
                                    ),
                                    content: ServiceTimingDialog());
                              });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: ColorManager.lightGrey,
                                blurRadius: 5.5,
                                spreadRadius: 2.5,
                                blurStyle: BlurStyle.normal)
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 17, bottom: 17, left: 14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Image.asset(
                                    AssetImages.laundry,
                                    height: 42,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorManager.lightGrey,
                                          blurRadius: 5.5,
                                          spreadRadius: 2.5,
                                          blurStyle: BlurStyle.normal)
                                    ],
                                    color: ColorManager.whiteColor,
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              15.pw,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    laundry.name.toString(),
                                    style: getMediumStyle(
                                        color: Color(0xFF1F2732),
                                        fontSize: FontSize.s16),
                                  ),
                                  7.ph,
                                  Row(
                                    children: [
                                      Image.asset(
                                        AssetImages.rating,
                                        height: 12,
                                      ),
                                      2.pw,
                                      Text(
                                        laundry.rating.toString(),
                                        style: getMediumStyle(
                                            color: Color(0xFF1F2732),
                                            fontSize: FontSize.s10),
                                      ),
                                      7.pw,
                                      Image.asset(
                                        AssetImages.address,
                                        height: 12,
                                      ),
                                      2.pw,
                                      Text(
                                        '${laundry.distance}',
                                        style: getRegularStyle(
                                            color: Color(0xFF1F2732),
                                            fontSize: FontSize.s10),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              });
            }, error: (e, s) {
              return Loader();
            }, loading: () {
              return Loader();
            }),
          ] else ...[
            ReusableOrderNowCard(
                image: getOrderNowImage(
                        serviceName: selectedService!.serviceName!) ??
                    "",
                onPressed: () {
                  showDialog<void>(
                      useSafeArea: true,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            insetPadding: const EdgeInsets.all(10),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            title: Center(
                              child: Heading(
                                title: 'Select Service Type',
                              ),
                            ),
                            content: ServiceTimingDialog());
                      });
                }),
            10.ph,
            branchbyArea.when(
                data: (data) {
                  return data.fold((l) {
                    return Text(l.toString());
                  }, (r) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      shrinkWrap: true,
                      itemCount: r.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        laundrybyareamodel.Datum laundry = r.data![index];

                        return ResuableLaundryTile(
                          onTap: () async {
                            ref
                                .read(laundriessProvider.notifier)
                                .selectedLaundryByArea(
                                    selectedLaundryByArea: laundry);

                            bool isAvailable = await ref
                                .read(laundriessProvider.notifier)
                                .nearByAgents(
                                    latitude: selectedAddress!.lat!,
                                    longitude: selectedAddress.lng!,
                                    ref: ref,
                                    context: context);

                            if (isAvailable) {
                              showDialog<void>(
                                  useSafeArea: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        insetPadding: const EdgeInsets.all(10),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        title: Center(
                                          child: Heading(
                                            title: 'Select Service Type',
                                          ),
                                        ),
                                        content: ServiceTimingDialog());
                                  });
                            }
                          },
                          laundry: laundry,
                        );
                      },
                    );
                  });
                },
                error: (e, s) => Text(e.toString()),
                loading: () => Loader()),
            pickupLaundires.when(data: (data) {
              return data.fold((l) {
                return Loader();
              }, (r) {
                List<GoogleLaundryModel> laundries = r;
                return Column(
                  children: [
                    10.ph,
                    DelieveryPickupHeading(),
                    10.ph,
                    ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: laundries.length,
                      itemBuilder: (BuildContext context, int index) {
                        GoogleLaundryModel laundry = laundries[index];
                        return ResuableDeliveryPickuPLaundryTile(
                          laundry: laundry,
                          onTap: () async {
                            ref
                                .read(laundriessProvider.notifier)
                                .selectedLaundry(selectedLaundry: laundry);

                            bool isAvailable = await ref
                                .read(laundriessProvider.notifier)
                                .nearByAgents(
                                    latitude: selectedAddress!.lat!,
                                    longitude: selectedAddress.lng!,
                                    ref: ref,
                                    context: context);

                            if (isAvailable) {
                              GoRouter.of(context)
                                  .pushNamed(RouteNames.deliveryPickup);
                            }
                          },
                        );
                      },
                    ),
                  ],
                );
              });
            }, error: (e, s) {
              return Loader();
            }, loading: () {
              return Loader();
            })
          ]
        ]),
      ),
    );
  }
}
