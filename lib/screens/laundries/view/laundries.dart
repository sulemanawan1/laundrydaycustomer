import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/screens/laundries/components/delivery_pickup_heading.dart';
import 'package:laundryday/screens/laundries/model/delivery_pickup_laundry_model.dart';
import 'package:laundryday/screens/laundries/model/services_timings_model.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/laundries/provider/laundries_states.dart';
import 'package:laundryday/screens/laundries/provider/service_timing_notifier.dart';
import 'package:laundryday/screens/laundries/provider/service_timing_states.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/core/constants/api_routes.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/routes/route_names.dart';
import 'package:laundryday/core/theme/styles_manager.dart';
import 'package:laundryday/core/widgets/heading.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_loader.dart';
import 'package:laundryday/core/widgets/reusable_order_now_widget.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;
import 'package:laundryday/screens/laundries/model/laundry_by_area.model.dart'
    as laundrybyareamodel;
import 'package:laundryday/core/widgets/reuseable_laundry_tile.dart';

class Laundries extends ConsumerStatefulWidget {
  servicemodel.Datum? services;

  Laundries({super.key, required this.services});

  @override
  ConsumerState<Laundries> createState() => _LaundriesState();
}

class _LaundriesState extends ConsumerState<Laundries> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      final selectedAddress = ref.read(selectedAddressProvider);

      ref.read(laundriessProvider.notifier).branchByArea(
          serviceId: widget.services?.id ?? 0,
          district: selectedAddress!.district ?? '',
          userLat: selectedAddress.lat ?? 0.0,
          userLng: selectedAddress.lng ?? 0 / 0);

      ref.read(laundriessProvider.notifier).deliveryPickupLaundries(
          userLat: selectedAddress.lat!, userLng: selectedAddress.lng!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final serviceTimingController = ref.read(serviceTimingProvider.notifier);
    final laundryByAreaState = ref.watch(laundriessProvider).laundryByAreaState;
    final deliveryPickupLaundryState =
        ref.watch(laundriessProvider).deliveryPickupLaundryState;

    return Scaffold(
      appBar: MyAppBar(
        title: widget.services!.serviceName.toString(),
        iconColor: ColorManager.blackColor,
        backgroundColor: ColorManager.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ReusableOrderNowCard(
              image: getOrderNowImage(
                      serviceName: widget.services!.serviceName!) ??
                  "",
              onPressed: () {
                serviceTimingController.serviceTimings(
                    serviceId: widget.services!.id!);

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
                          content: ServiceTimingDialog(
                              serviceModel: widget.services!));
                    });
              }),

          if (laundryByAreaState is LaundryByAreaIntitialState) ...[
            // CircularProgressIndicator()
          ] else if (laundryByAreaState is LaundryByAreaLoadingState) ...[
            // CircularProgressIndicator()
          ] else if (laundryByAreaState is LaundryByAreaErrorState) ...[
            Text(laundryByAreaState.errorMessage)
          ] else if (laundryByAreaState is LaundryByAreaLoadedState) ...[
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shrinkWrap: true,
              itemCount: laundryByAreaState.laundryByAreaModel.data!.length,
              itemBuilder: (BuildContext context, int index) {
                laundrybyareamodel.Datum laundry =
                    laundryByAreaState.laundryByAreaModel.data![index];
                return ResuableLaundryTile(
                  onTap: () {
                    serviceTimingController.serviceTimings(
                        serviceId: widget.services!.id!);

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
                              content: ServiceTimingDialog(
                                  serviceModel: widget.services!));
                        });
                  },
                  laundry: laundry,
                );
              },
            ),
          ],
          // Delivery Pickup Laundries

          if (deliveryPickupLaundryState
              is DeliveryPickupLaundryIntitialState) ...[
            CircularProgressIndicator()
          ] else if (deliveryPickupLaundryState
              is DeliveryPickupLaundryLoadingState) ...[
            CircularProgressIndicator()
          ] else if (deliveryPickupLaundryState
              is DeliveryPickupLaundryLoadedState) ...[
            10.ph,
            DelieveryPickupHeading(),
            10.ph,
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  deliveryPickupLaundryState.deliveryPickupLaundryModel.length,
              itemBuilder: (BuildContext context, int index) {
                DeliveryPickupLaundryModel laundry = deliveryPickupLaundryState
                    .deliveryPickupLaundryModel[index];
                return ResuableDeliveryPickuPLaundryTile(
                  laundry: laundry,
                  onTap: () {
                    //     extra: {
                    //   'vechile_info': agent.vechileInfo!.toJson(),
                    //   'user_image': agent.user!.image.toString(),
                    //   'identity_image': agent.identityImage.toString()
                    // }
                    GoRouter.of(context).pushNamed(RouteNames().deliveryPickup,
                        extra: {
                          'laundry': laundry,
                          'service': widget.services
                        });
                  },
                );
              },
            ),
          ] else if (deliveryPickupLaundryState
              is DeliveryPickupLaundryErrorState) ...[
            Text(deliveryPickupLaundryState.errorMessage)
          ]
        ]),
      ),
    );
  }

  String? getOrderNowImage({required String serviceName}) {
    if (serviceName.toLowerCase() == 'clothes') {
      return "assets/order_now_clothes.jpeg";
    } else if (serviceName.toLowerCase() == 'blankets') {
      return "assets/order_now_blankets.jpeg";
    }
    return null;
  }
}

class ServiceTimingDialog extends ConsumerWidget {
  final servicemodel.Datum serviceModel;
  const ServiceTimingDialog({
    required this.serviceModel,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceTimingStates =
        ref.watch(serviceTimingProvider).serviceTimingState;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (serviceTimingStates is ServiceTimingIntitialState) ...[
        Loader()
      ] else if (serviceTimingStates is ServiceTimingLoadingState) ...[
        Loader()
      ] else if (serviceTimingStates is ServiceTimingErrorState) ...[
        Text(serviceTimingStates.errorMessage)
      ] else if (serviceTimingStates is ServiceTimingLoadedState) ...[
        _buildServiceTimingList(
            ref: ref,
            serviceTimingList: serviceTimingStates.serviceTimingModel.data!,
            context: context,
            service: serviceModel)
      ]
    ]);
  }

  Widget _buildServiceTimingList(
      {required WidgetRef ref,
      required List<Datum> serviceTimingList,
      required BuildContext context,
      required servicemodel.Datum service}) {
    return Column(
      children: List.generate(serviceTimingList.length, (int index) {
        var serviceTiming = serviceTimingList[index];

        return GestureDetector(
          onTap: () {
            ref
                .read(laundriessProvider.notifier)
                .selectedServiceTiming(serviceTiming: serviceTiming);

            if (service.serviceName!.toLowerCase() == 'clothes') {
              context.pushNamed(RouteNames().laundryItems, extra: service);
              context.pop();
            }
          },
          child: SizedBox(
            width: 200,
            child: Card(
              color: ColorManager.purpleColorOpacity10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.ph,
                      Image.network(
                          color: ColorManager.purpleColor,
                          height: 60,
                          "${Api.imageUrl}${serviceTiming.image}"),
                      10.ph,
                      Text(
                        serviceTiming.name!,
                        style: getSemiBoldStyle(color: ColorManager.blackColor),
                      ),
                      10.ph,
                      Text(
                        textAlign: TextAlign.center,
                        serviceTiming.description!,
                        style: getRegularStyle(color: ColorManager.blackColor),
                      ),
                      10.ph,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
