import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/config/resources/assets_manager.dart';
import 'package:laundryday/config/resources/font_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/widgets/my_loader.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/services/components/address_bottom_sheet_widget.dart';
import 'package:laundryday/screens/services/model/customer_order_model.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/screens/services/provider/services_states.dart';
import 'package:laundryday/config/resources/api_routes.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:shimmer/shimmer.dart';

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

    CustomerOrderStates customerOrderStates =
        ref.watch(serviceProvider).customerOrderStates;
    List<Order> orders = ref.watch(serviceProvider).order;

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
            // await Future.wait([
            //   serviceAddress.getAddress(),

            //   serviceAddress.allAddresses(customerId: customerId!)
            // ]);

            // await serviceAddress.getAddress();
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
              if (services is AllServicesInitialState) ...[
                ServiceShimmerEffect()
              ] else if (services is AllServicesLoadingState) ...[
                ServiceShimmerEffect()
              ] else if (services is AllServicesErrorState) ...[
                ServiceShimmerEffect()
              ] else if (services is AllServicesLoadedState) ...[
                10.ph,
                if (customerOrderStates is CustomerOrderInititalState) ...[
                  Loader()
                ] else if (customerOrderStates
                    is CustomerOrderLoadingState) ...[
                  Loader()
                ] else if (customerOrderStates is CustomerOrderErrorState) ...[
                  Loader()
                ] else if (customerOrderStates is CustomerOrderLoadedState) ...[
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          context.pushReplacementNamed(RouteNames.orderProcess,
                              extra: orders[index].id);
                        },
                        child: Card(
                          color: ColorManager.silverWhite,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                5.ph,
                                ListTile(
                                  title:
                                      Text(orders[index].branchName.toString()),
                                  leading: Image.asset(
                                    AssetImages.laundryIcon,
                                    width: 40,
                                  ),
                                  trailing: Text(
                                    orders[index].id.toString(),
                                    style: getSemiBoldStyle(
                                        color: ColorManager.greyColor,
                                        fontSize: FontSize.s12),
                                  ),
                                ),
                                5.ph,
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: orders[index]
                                        .orderStatuses!
                                        .map((e) => (e.status == 'pending' ||
                                                    e.status == 'accepted') ||
                                                e.status == 'received' ||
                                                e.status == 'at_customer'
                                            ? Expanded(
                                                flex: orders[index].status ==
                                                        e.status
                                                    ? 2
                                                    : 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: AppPadding.p6),
                                                  child: Container(
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppSize.s4),
                                                        color: orders[index]
                                                                    .status ==
                                                                e.status
                                                            ? Color(0xFF7862EB)
                                                                .withOpacity(
                                                                    0.3)
                                                            : Color(
                                                                0xFF7862EB)),
                                                  ),
                                                ),
                                              )
                                            : Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: AppPadding.p6),
                                                  child: Container(
                                                    width: 30,
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppSize.s4),
                                                        color:
                                                            Color(0xFFD9D9D9)),
                                                  ),
                                                ),
                                              ))
                                        .toList()),
                                5.ph,
                                Text(
                                  getOrderStatusMessage(
                                      status: orders[index].status!),
                                  style: getSemiBoldStyle(
                                      color: ColorManager.nprimaryColor,
                                      fontSize: FontSize.s12),
                                ),
                                5.ph
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
                )
              ] else ...[
                ServiceShimmerEffect()
              ]
            ])),
      ),
    );
  }

  String getOrderStatusMessage({required String status}) {
    switch (status) {
      case 'pending':
        return 'Searching for Courier';
      case 'accepted':
        return 'Delivery Agent arrived to Laundry.';
      case 'received':
        return 'Delivery Agent Recived the order.';
      case 'at_customer':
        return 'Delivery Agent near you';
      case 'delivered':
        return 'Order is delivered';
      case 'canceled':
        return 'Order is canceled';
      default:
        return 'Unknown order status';
    }
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

class CustomCacheNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final BoxFit? fit;
  CustomCacheNetworkImage(
      {super.key, required this.imageUrl, required this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      fadeInDuration: Duration(seconds: 1),
      placeholder: (context, url) => SizedBox(
        height: height,
        child: Loader(),
      ),
      errorWidget: (context, url, error) => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image,
                color: ColorManager.greyColor,
              ),
              10.ph,
              Text(
                'File Not Found',
                style: getRegularStyle(color: ColorManager.blackColor),
              )
            ],
          ),
        ),
        height: height,
        width: double.infinity,
      ),
    );
  }
}
