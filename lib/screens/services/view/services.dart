import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/screens/services/components/customer_on_going_order_card.dart';
import 'package:laundryday/screens/services/components/service_shimmer_effect.dart';
import 'package:laundryday/widgets/custom_cache_netowork_image.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/services/components/address_bottom_sheet_widget.dart';
import 'package:laundryday/screens/services/model/customer_order_model.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/screens/services/provider/services_states.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ConsumerState<Services> createState() => _ServicesState();
}

class _ServicesState extends ConsumerState<Services> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllServicesState? services = ref.watch(serviceProvider).allServicesState;

    final customerOrders = ref.watch(customerOrderProvider);

    final customerId = ref.read(userProvider).userModel!.user!.id;
    LatLng? latLng = ref.watch(addressProvider).latLng;

    String? district = ref.watch(addressProvider).district;

    myaddressmodel.Address? selectedAddress =
        ref.watch(selectedAddressProvider);

    final serviceAddress = ref.read(addressProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.primaryColor, size: 24),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(241, 240, 245, 1),
        leadingWidth: MediaQuery.of(context).size.width * .8,
        leading: GestureDetector(
          onTap: () async {
            await serviceAddress.allAddresses(customerId: customerId!);

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
                          style: getRegularStyle(
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
              customerOrders.when(
                  data: (data) {
                    return data.fold((l) {
                      return Text(l);
                    }, (r) {
                      List<Order> orders = r.order!;
                      return CustomerOnGoingOrderCard(orders: orders);
                    });
                  },
                  error: (e, err) => Text(e.toString()),
                  loading: () => Loader()),




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
                          serviceAddress.allAddresses(customerId: customerId!);

                          showModalBottomSheet<void>(
                            isDismissible: false,
                            useSafeArea: true,
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(AppSize.s8),
                                    topRight: Radius.circular(AppSize.s8))),
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
                                    child: CustomCacheNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "${Api.imageUrl}${services.serviceModel.data![index].serviceImage.toString()}",
                                      height: 155,
                                    )),
                              ),
                              14.ph,
                              Text(
                                services.serviceModel.data![index].serviceName
                                    .toString(),
                                style: getSemiBoldStyle(
                                    color: ColorManager.blackColor,
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
                ),
              ] else ...[
                ServiceShimmerEffect()
              ]
            ])),
      ),
    );
  }
}
