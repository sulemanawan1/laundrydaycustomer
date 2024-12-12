import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/constants/assets_manager.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/models/order_list_model.dart';
import 'package:laundryday/screens/order_process/view/order_process.dart';
import 'package:laundryday/screens/services/components/customer_on_going_order_card.dart';
import 'package:laundryday/screens/services/components/services_shimmer_effect.dart';
import 'package:laundryday/screens/services/components/services_card.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/screens/services/components/address_bottom_sheet_widget.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressmodel;
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

import '../../../models/services_model.dart';

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ConsumerState<Services> createState() => _ServicesState();
}

class _ServicesState extends ConsumerState<Services> {
  @override
  void initState() {



    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log(message.data['type']);
      log(message.data['data'].toString());
      var data = jsonDecode(message.data['data'].toString());

      log('Received a foreground message: ${message.notification?.title}');

      if (message.data['type'] == 'Order') {
        int orderId = data['order']['id'];
        ref.invalidate(customerOrderProvider);
        ref.invalidate(pendingPickupRequestProvider);
        ref
            .read(orderProcessProvider.notifier)
            .getOrderDetail(orderId: orderId, ref: ref, context: context);

      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {

      log(message.data['type'].toString());
      log(message.data['data'].toString());
      log('Notificaton Taped: ${message.notification?.title}');
      var data = jsonDecode(message.data['data'].toString());

      if (message.data['type'] == 'Order') {
        int orderId = data['order']['id'];


        ref.invalidate(customerOrderProvider);
        ref.invalidate(pendingPickupRequestProvider);


        ref
            .read(orderProcessProvider.notifier)
            .getOrderDetail(orderId: orderId, ref: ref, context: context);
      }
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final customerOrders = ref.watch(customerOrderProvider);
    final pendingPickupRequests = ref.watch(pendingPickupRequestProvider);
    final services = ref.watch(servicesProvider);
    myaddressmodel.Address? selectedAddress =
        ref.watch(selectedAddressProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.primaryColor, size: 24),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(241, 240, 245, 1),
        leadingWidth: MediaQuery.of(context).size.width * .8,
        leading: GestureDetector(
          onTap: () {
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
                            Text("Delivered to",
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
                          selectedAddress?.addressDetail == 'my-current-address'
                              ? 'Current Location'
                              : selectedAddress?.googleMapAddress ??
                                  "Current Location",
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(
                            fontSize: 13,
                            color: selectedAddress?.addressDetail ==
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
      body: RefreshIndicator(
        color: ColorManager.nprimaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    10.ph,

                    pendingPickupRequests.when(
                        data: (data) {
                          return data.fold((l) {
                            return Text(l);
                          }, (r) {
                            int totalCount = r.totalCount!;

                            return totalCount > 0
                                ? Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorManager.nprimaryColor),
                                    child: InkWell(
                                      onTap: () {
                                        log(r.orders!.length.toString());

                                        context.pushNamed(
                                            RouteNames.pendingPickupRequests,
                                            extra: r);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              child: Center(
                                                child: Container(
                                                  height: 24,
                                                  width: 24,
                                                  child: Center(
                                                    child: Image.asset(
                                                      AssetImages.tick,
                                                      height: 7.64,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: ColorManager
                                                          .nprimaryColor),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: ColorManager.whiteColor
                                                      .withOpacity(0.5),
                                                  shape: BoxShape.circle),
                                            ),
                                            10.pw,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Pending Pickup Requests',
                                                  style: getMediumStyle(
                                                      fontSize: FontSize.s12,
                                                      color: ColorManager
                                                          .whiteColor),
                                                ),
                                                Text(
                                                  'Total  $totalCount',
                                                  style: getRegularStyle(
                                                      fontSize: FontSize.s10,
                                                      color: ColorManager
                                                          .whiteColor),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    AppPadding.p10),
                                                child: Center(
                                                  child: Text(
                                                    '${totalCount}',
                                                    style: getSemiBoldStyle(
                                                        fontSize: FontSize.s10,
                                                        color:
                                                            Color(0xFFC4F3DF)),
                                                  ),
                                                ),
                                              ),
                                              foregroundDecoration:
                                                  BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 3,
                                                          color: Color(
                                                              0xFFC4F3DF))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          });
                        },
                        error: (e, err) => Text(e.toString()),
                        loading: () => Loader()),

                    // Cutomer on going Orders
                    customerOrders.when(
                        data: (data) {
                          return data.fold((l) {
                            return Text(l);
                          }, (r) {
                            List<Order> orders = r.orders!;
                            return CustomerOnGoingOrderCard(orders: orders);
                          });
                        },
                        error: (e, err) => Text(e.toString()),
                        loading: () => Loader()),

                    // Services
                    services.when(
                        data: (data) {
                          return data.fold((l) {
                            return ServiceShimmerEffect();
                          }, (r) {
                            List<Datum>? serviceModel = r.data;
                            return ServicesCard(serviceModel: serviceModel);
                          });
                        },
                        error: (e, err) => ServiceShimmerEffect(),
                        loading: () => ServiceShimmerEffect())
                  ])),
        ),
        onRefresh: () => Future.wait([
          ref.refresh(pendingPickupRequestProvider.future),
          ref.refresh(servicesProvider.future),
          ref.refresh(customerOrderProvider.future)
        ]),
      ),
    );
  }
}
