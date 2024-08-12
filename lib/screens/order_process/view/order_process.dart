import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/config/resources/pusher_handler.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:laundryday/config/resources/assets_manager.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/font_manager.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_loader.dart';
import 'package:laundryday/screens/order_process/providers/order_process_notifier.dart';
import 'package:laundryday/screens/order_process/providers/order_process_states.dart';

final orderProcessProvider =
    StateNotifierProvider.autoDispose<OrderProcessNotifier, OrderProcessStates>(
        (ref) => OrderProcessNotifier());

class OrderProcess extends ConsumerStatefulWidget {
  final int orderId;
  OrderProcess({
    required this.orderId,
    super.key,
  });

  @override
  ConsumerState<OrderProcess> createState() => _OrderProcessState();
}

class _OrderProcessState extends ConsumerState<OrderProcess> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      ref
          .read(orderProcessProvider.notifier)
          .getOrderDetail(orderId: widget.orderId, ref: ref, context: context);

      final userModel = ref.read(userProvider).userModel;

      PusherHandler(userModel: userModel!, ref: ref).initCLinet();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var orderState = ref.watch(orderProcessProvider).orderState;
    var orderModel = ref.watch(orderProcessProvider).orderModel;

    return PopScope(
      onPopInvoked: (didPop) {
        context.goNamed(RouteNames().splash);
      },
      child: Scaffold(
          appBar: MyAppBar(
            onPressed: () {
              context.goNamed(RouteNames().splash);
            },
            title: 'order',
            actions: [
              PopupMenuButton(
                iconColor: ColorManager.blackColor,
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  // your logic
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      value: 'support',
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height * 0.2,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Support"),
                            Icon(Icons.support_agent)
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'cancel order',
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cancel Order",
                              style: getRegularStyle(color: Colors.red),
                            ),
                            const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ),
                  ];
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (orderState is OrderStateInitialState) ...[
                    Loader()
                  ] else if (orderState is OrderStateLoadingState) ...[
                    Loader()
                  ] else if (orderState is OrderStateLoadedState) ...[
                    34.85.ph,
                    Center(
                      child: Image.asset(
                        getStatusImage(status: orderModel!.order!.status!),
                        height: AppSize.s95,
                      ),
                    ),
                    25.ph,
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffDCE2EF)),
                          borderRadius: BorderRadius.circular(AppSize.s6)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p11_03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            17.ph,
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: orderModel.order!.orderStatuses!
                                    .map((e) => (e.status == 'pending' ||
                                            e.status == 'accepted')
                                        ? Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: AppPadding.p6),
                                              child: Container(
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s4),
                                                    color: Color(0xFF7862EB)),
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: AppPadding.p6),
                                              child: Container(
                                                width: 30,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s4),
                                                    color: Color(0xFFD9D9D9)),
                                              ),
                                            ),
                                          ))
                                    .toList()),
                            13.ph,
                            Text(
                              getOrderStatusMessage(
                                  status: orderModel.order!.status!),
                              style: getSemiBoldStyle(
                                  color: ColorManager.nprimaryColor,
                                  fontSize: FontSize.s16),
                            ),
                            5.ph,
                            Text(
                              getOrderDescription(
                                  status: orderModel.order!.status!),
                              style: getlightStyle(
                                  color: ColorManager.nlightGreyColor,
                                  fontSize: FontSize.s12),
                            ),
                            17.ph,
                          ],
                        ),
                      ),
                    ),
                    10.ph,
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppPadding.p21),
                        child: Column(
                          children: [
                            12.ph,
                            Row(
                              children: [
                                Image.asset(
                                  AssetImages.laundryIcon,
                                  width: 32,
                                ),
                                10.pw,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 142,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        orderModel.order!.branchName.toString(),
                                        style: getRegularStyle(
                                            fontSize: FontSize.s20,
                                            color: Color(0xFF525253)),
                                      ),
                                    ),
                                    Text(
                                      '20x items',
                                      style: getRegularStyle(
                                          fontSize: FontSize.s12,
                                          color: Color(0xFF525253)),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Details',
                                      style: getRegularStyle(
                                          color: ColorManager.nprimaryColor,
                                          fontSize: FontSize.s12),
                                    ),
                                    10.pw,
                                    Image.asset(
                                      AssetImages.forward,
                                      width: 11.11,
                                    )
                                  ],
                                ),
                                25.pw
                              ],
                            ),
                            10.ph
                          ],
                        ),
                      ),
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s8),
                          color: Color(0xFFF7F7F7)),
                    ),
                    10.ph,
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: AppPadding.p20,
                            top: AppPadding.p12,
                            bottom: AppPadding.p9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Number',
                              style: getRegularStyle(
                                  fontSize: FontSize.s16,
                                  color: Color(0xFF1F2732)),
                            ),
                            Row(
                              children: [
                                Text(
                                  orderModel.order!.id.toString(),
                                  style: getRegularStyle(
                                      fontSize: FontSize.s16,
                                      color: Color(0xFF1F2732)),
                                ),
                                7.pw,
                                Image.asset(
                                  AssetImages.clipboard,
                                  height: AppSize.s18,
                                ),
                                22.92.pw
                              ],
                            ),
                          ],
                        ),
                      ),
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s8),
                          color: Color(0xFFF7F7F7)),
                    ),
                    15.ph,
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      height: AppSize.s200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize
                            .s12), // Ensure the border radius matches the container
                    
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              zoom: 16,
                              target: LatLng(orderModel.order!.customerLat!,
                                  orderModel.order!.customerLng!)),
                          compassEnabled: false,
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                          mapToolbarEnabled: false,
                          onCameraIdle: () {},
                          onCameraMove: (cameraPos) {},
                          onMapCreated: (GoogleMapController gcontroller) {},
                        ),
                      ),
                    ),
                    orderModel.order!.orderDeliveries!.isNotEmpty
                        ? _courierDetails(context)
                        : SizedBox(),
                  ] else if (orderState is OrderStateErrorState) ...[
                    Text(orderState.errorMessage)
                  ]
                ]),
          )),
    );
  }

  Widget _courierDetails(BuildContext context) {
    return Column(
      children: [
        5.ph,
        Container(
          width: 80,
          height: 5,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 216, 213, 213),
              borderRadius: BorderRadius.circular(12)),
        ),
        5.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            5.pw,
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/icons/user.png'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Suleman Abrar'),
                        Row(
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  context.pushNamed(RouteNames().orderChat);
                                },
                                icon: const Icon(
                                    Icons.chat_bubble_outline_rounded)),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  Utils.showResuableBottomSheet(
                                      context: context,
                                      widget: Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: TextButton(
                                                onPressed: () async {
                                                  var uri = Uri.parse(
                                                      "tel://${05134357098}");

                                                  try {
                                                    await launchUrl(uri);

                                                    // ignore: use_build_context_synchronously
                                                    context.pop();
                                                  } catch (e) {
                                                    Utils.showToast(
                                                        msg: e.toString(),
                                                        isNegative: true);
                                                  }
                                                },
                                                child: Text(
                                                  '05134357098',
                                                  style: getMediumStyle(
                                                      color: ColorManager
                                                          .blackColor),
                                                )),
                                          ),
                                          const Divider(),
                                          SizedBox(
                                            width: double.infinity,
                                            child: TextButton(
                                                onPressed: () {
                                                  context.pop();
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: getMediumStyle(
                                                      color: ColorManager
                                                          .blackColor),
                                                )),
                                          ),
                                          10.ph
                                        ],
                                      ),
                                      title: 'Call');
                                },
                                icon: const Icon(Icons.call)),
                          ],
                        )
                      ],
                    ),
                    Text(
                      'Courier',
                      style: getRegularStyle(
                        color: ColorManager.greyColor,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber,
                        ),
                        5.pw,
                        Text(
                          '4',
                          style:
                              getSemiBoldStyle(color: ColorManager.blackColor),
                        ),
                        5.pw,
                        Text(
                          'base on (16)',
                          style:
                              getRegularStyle(color: ColorManager.blackColor),
                        ),
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateColor.resolveWith(
                                    (states) => Colors.transparent)),
                            onPressed: () {},
                            child: Text(
                              'Reviews',
                              style: getRegularStyle(
                                  color: ColorManager.primaryColor),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.directions_car),
                            5.pw,
                            const Text('2023 Honda Civic'),
                          ],
                        ),
                        Text(
                          '9194',
                          style: getMediumStyle(color: ColorManager.blackColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        5.ph,
      ],
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Availability'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "If you are present at your location, press the 'I'm Available' button. Otherwise, select your availability time. This way, your order will be delivered at your chosen time."),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(
                Icons.schedule,
                color: Colors.grey,
              ),
              label: Text(
                'Set availability',
                style: getRegularStyle(color: ColorManager.amber),
              ),
              onPressed: () {
                _selectTime(context);
              },
            ),
            TextButton(
              child: Text(
                "I'm available",
                style: getRegularStyle(color: ColorManager.primaryColor),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  String getOrderStatusMessage({required String status}) {
    switch (status) {
      case 'pending':
        return 'Searching for Courier';
      case 'accepted':
        return 'Delivery Agent arrived to Laundry.';
      case 'shipped':
        return 'Order is shipped';
      case 'delivered':
        return 'Order is delivered';
      case 'canceled':
        return 'Order is canceled';
      default:
        return 'Unknown order status';
    }
  }

  String getStatusImage({required String status}) {
    switch (status) {
      case 'pending':
        return AssetImages.pendingStatus;
      case 'accepted':
        return AssetImages.acceptedStatus;

      default:
        return AssetImages.pendingStatus;
    }
  }

  String getOrderDescription({required String status}) {
    switch (status) {
      case 'pending':
        return """Patience always pay off.kindly allow us some time while we are looking for available courier.""";
      case 'accepted':
        return 'Delivery Agent Arrived to store and he will get your order soon';
      case 'shipped':
        return 'Order is shipped';
      case 'delivered':
        return 'Order is delivered';
      case 'canceled':
        return 'Order is canceled';
      default:
        return 'Unknown order status';
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay currentTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dialOnly,
      initialTime: currentTime,
    );
    const TimeOfDay nineAm = TimeOfDay(hour: 9, minute: 00);
    const TimeOfDay tweleveAm = TimeOfDay(hour: 00, minute: 00);

    if (picked != null) {
      if (picked.hour > nineAm.hour && picked.hour > tweleveAm.hour) {
        selectedTime = picked;
        context.pop();
      } else {
        Utils.showToast(msg: 'The Availbilty Time Must between 9 AM to  12 AM');
      }
      setState(() {});
    }
  }
}

class OrderStatusDetailModel {
  final String title;
  final String description;
  OrderStatusDetailModel({
    required this.title,
    required this.description,
  });
}
