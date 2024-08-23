import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:laundryday/config/resources/assets_manager.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/font_manager.dart';
import 'package:laundryday/config/resources/pusher_handler.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_loader.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/order_process/providers/order_process_notifier.dart';
import 'package:laundryday/screens/order_process/providers/order_process_states.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';

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

    String? fourDigitCode;
    List<String>? code;

    if (orderModel.order?.id != null) {
      fourDigitCode = orderModel.order!.code.toString();
      code = fourDigitCode.split('');
    }

    log('build');
    return Scaffold(
        appBar: MyAppBar(
          onPressed: () {
            Future.delayed(Duration(seconds: 0), () {
              ref.invalidate(serviceProvider);

              context.goNamed(RouteNames.home);
            });
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
                        children: [Text("Support"), Icon(Icons.support_agent)],
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            if (orderState is OrderStateInitialState) ...[
              Loader()
            ] else if (orderState is OrderStateLoadingState) ...[
              Loader()
            ] else if (orderState is OrderStateLoadedState) ...[
              10.85.ph,
              Center(
                child: Image.asset(
                  getStatusImage(status: orderModel.order!.status!),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p11_03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((orderModel.order!.status == 'delivered') ||
                          (orderModel.order!.status == 'canceled'))
                        ...[]
                      else ...[
                        17.ph,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: orderModel.order!.orderStatuses!
                                .map((e) => (e.status == 'pending' ||
                                            e.status == 'accepted') ||
                                        e.status == 'received' ||
                                        e.status == 'at_customer' ||
                                        e.status == 'delivered'
                                    ? Expanded(
                                        flex:
                                            orderModel.order!.status == e.status
                                                ? 2
                                                : 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: AppPadding.p6),
                                          child: Container(
                                            height: 5,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(AppSize.s4),
                                                color:
                                                    orderModel.order!.status ==
                                                            e.status
                                                        ? Color(0xFF7862EB)
                                                            .withOpacity(0.3)
                                                        : Color(0xFF7862EB)),
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
                      ],
                      13.ph,
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getOrderStatusMessage(
                                      status: orderModel.order!.status!),
                                  style: getSemiBoldStyle(
                                      color: ColorManager.nprimaryColor,
                                      fontSize: FontSize.s16),
                                ),
                                5.ph,
                                Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  getOrderDescription(
                                      status: orderModel.order!.status!),
                                  style: getlightStyle(
                                      color: ColorManager.nlightGreyColor,
                                      fontSize: FontSize.s12),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          if (orderModel.order?.countDownStart != null) ...[
                            Expanded(
                              child: TimerWidget(
                                countDownStart: orderModel.order!.countDownEnd!,
                                countDownEnd: orderModel.order!.countDownStart!,
                              ),
                            )
                          ]
                        ],
                      ),
                      17.ph,
                    ],
                  ),
                ),
              ),
              10.ph,
              if (orderModel.order!.status == 'at_customer') ...[
                15.ph,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    width: 315,
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEFE),
                        borderRadius: BorderRadius.circular(6)),
                    child: Column(
                      children: [
                        13.ph,
                        Row(
                          children: [
                            18.pw,
                            Image.asset(
                              AssetImages.fourDigitCode,
                              height: 16,
                            ),
                            10.pw,
                            Text(
                                textAlign: TextAlign.center,
                                'Share the four-digit code with the courier\n to finalize the order',
                                style: getRegularStyle(
                                    fontSize: 10, color: Color(0xFF494B4F)))
                          ],
                        ),
                        13.ph,
                      ],
                    ),
                  ),
                ),
                15.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: code!.map((char) {
                    return Container(
                      width: AppSize.s46,
                      height: AppSize.s46,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      // padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(158, 158, 158, 1)
                                .withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        border: Border.all(width: 1, color: Color(0xFFE3E5E5)),
                        color: ColorManager.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(char,
                            style: getSemiBoldStyle(
                                fontSize: 16,
                                color: ColorManager.nprimaryColor)),
                      ),
                    );
                  }).toList(),
                ),
                20.ph,
              ],
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
                              if (orderModel.order!.totalItems != 0) ...[
                                Text(
                                  '20x items',
                                  style: getRegularStyle(
                                      fontSize: FontSize.s12,
                                      color: Color(0xFF525253)),
                                )
                              ]
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                      ClipboardData(text: orderModel.order!.id.toString()));
                },
                child: Container(
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
                              fontSize: FontSize.s16, color: Color(0xFF1F2732)),
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
              ),
              10.ph,
              if (orderModel.order!.paymentStatus == 'unpaid') ...[
                GestureDetector(
                  onTap: () {
                    context.pushNamed(RouteNames.orderCheckout,
                        extra: orderModel);
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p20,
                          top: AppPadding.p12,
                          bottom: AppPadding.p9),
                      child: Row(
                        children: [
                          Text(
                            'Invoice and Payments',
                            style: getRegularStyle(
                                fontSize: FontSize.s16,
                                color: ColorManager.whiteColor),
                          ),
                          Spacer(),
                          Image.asset(
                            AssetImages.forward,
                            height: AppSize.s18,
                            color: ColorManager.whiteColor,
                          ),
                          13.pw
                        ],
                      ),
                    ),
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s8),
                        color: ColorManager.nprimaryColor),
                  ),
                ),
              ],
              15.ph,
              if (orderModel.order?.orderDeliveries != null) ...[
                DeliveryAgentCard(
                    orderDeliveries: orderModel.order!.orderDeliveries!),
              ],
              35.ph,
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
              35.ph,
            ] else if (orderState is OrderStateErrorState) ...[
              Text(orderState.errorMessage)
            ]
          ]),
        ));
  }

  Future<void> showMyDialog() async {
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
        return 'Agent arrived to Laundry.';
      case 'received':
        return 'Agent Recived the order.';
      case 'at_customer':
        return 'Agent near you';
      case 'delivered':
        return 'Order is completed';
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
      case 'received':
        return AssetImages.recivedStatus;
      case 'at_customer':
        return AssetImages.atCustomerStatus;
      case 'delivered':
        return AssetImages.deliveredStatus;
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
      case 'received':
        return 'Delivery Agent  recieved order, he is on his way.';
      case 'at_customer':
        return 'Delivery Agent near you , be ready to get your order.';

      case 'delivered':
        return 'Your Order is completed, we hope to see you again';
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

class CounDownStates {
  Duration remainingTime;
  double countDownProgress;

  CounDownStates({
    required this.countDownProgress,
    required this.remainingTime,
  });

  CounDownStates copyWith(
      {Duration? remainingTime, double? countDownProgress}) {
    return CounDownStates(
      countDownProgress: countDownProgress ?? this.countDownProgress,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }
}

final countDownProvider =
    StateNotifierProvider<CountDownStateNotifer, CounDownStates>(
        (ref) => CountDownStateNotifer());

class CountDownStateNotifer extends StateNotifier<CounDownStates> {
  CountDownStateNotifer()
      : super(CounDownStates(
            countDownProgress: 0.0, remainingTime: Duration.zero));

  void updateTimeRemaining(
      {required DateTime countDownStart, required DateTime countDownEnd}) {
    print(countDownEnd);
    final now = DateTime.now();
    if (countDownStart.isAfter(now)) {
      state.remainingTime = countDownStart.difference(now);

      state.countDownProgress = 1.0 -
          state.remainingTime.inSeconds /
              (countDownStart.difference(countDownEnd).inSeconds);

      print(state.countDownProgress);

      state = state.copyWith(
          remainingTime: state.remainingTime,
          countDownProgress: state.countDownProgress);
    } else {
      state.remainingTime = Duration.zero;
      state.countDownProgress = 0.0;
      state = state.copyWith(
          remainingTime: state.remainingTime,
          countDownProgress: state.countDownProgress);
    }
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class TimerWidget extends ConsumerStatefulWidget {
  TimerWidget({
    super.key,
    required this.countDownStart,
    required this.countDownEnd,
  });

  final DateTime countDownStart;
  final DateTime countDownEnd;

  @override
  ConsumerState<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends ConsumerState<TimerWidget> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      ref.read(countDownProvider.notifier).updateTimeRemaining(
          countDownStart: widget.countDownStart,
          countDownEnd: widget.countDownEnd);

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        ref.read(countDownProvider.notifier).updateTimeRemaining(
            countDownStart: widget.countDownStart,
            countDownEnd: widget.countDownEnd);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = ref.watch(countDownProvider).remainingTime;
    final countDownProgress = ref.watch(countDownProvider).countDownProgress;

    return  Column(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            value: countDownProgress,
            backgroundColor: ColorManager.nprimaryColor.withOpacity(0.2),
            strokeWidth: 5.0,
            color: ColorManager.nprimaryColor,
          ),
        ),
        9.ph,
        Text(
          ref.read(countDownProvider.notifier).formatDuration(remainingTime),
          style: getRegularStyle(color: ColorManager.blackColor, fontSize: 8),
        )
      ],
    );
  }
}

class DeliveryAgentCard extends StatelessWidget {
  final OrderDeliveries orderDeliveries;

  DeliveryAgentCard({
    super.key,
    required this.orderDeliveries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                22.ph,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          14.pw,
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AssetImages.user)),
                                color: ColorManager.nprimaryColor,
                                shape: BoxShape.circle),
                          ),
                          14.pw,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${orderDeliveries.user?.firstName}${orderDeliveries.user?.lastName}",
                                style: getRegularStyle(
                                    color: Color(0xFF242E42),
                                    fontSize: FontSize.s17),
                              ),
                              7.ph,
                              Row(
                                children: [
                                  Image.asset(width: 16, AssetImages.rating),
                                  5.pw,
                                  Text(
                                    "4.2",
                                    style: getRegularStyle(
                                        color: Color(0xFFC8C7CC),
                                        fontSize: FontSize.s15),
                                  ),
                                ],
                              ),
                              10.ph,
                              Text("Delivery Agent",
                                  style: getMediumStyle(
                                      color: Color(0xFF242E42),
                                      fontSize: FontSize.s14)),
                              10.ph,
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                context.pushNamed(RouteNames.orderChat);
                              },
                              child: Image.asset(width: 40, AssetImages.chat)),
                          16.pw,
                          GestureDetector(
                              onTap: () async {
                                var uri = Uri.parse(
                                    "tel://${orderDeliveries.deliveryAgent!.mobileNumber}");

                                try {
                                  await launchUrl(uri);

                                  // ignore: use_build_context_synchronously
                                  context.pop();
                                } catch (e) {
                                  Utils.showToast(
                                      msg: e.toString(), isNegative: true);
                                }
                              },
                              child: Image.asset(width: 40, AssetImages.call)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s8),
                topRight: Radius.circular(AppSize.s8),
              ),
            ),
          ),
          23.ph,
          Row(
            children: [
              29.05.pw,
              Image.asset(width: AppSize.s50, AssetImages.car),
              27.4.pw,
              SizedBox(
                width: 180,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "2012 honda civic",
                  style: getRegularStyle(
                      color: Color(0xFF242E42), fontSize: FontSize.s16),
                ),
              ),
              Spacer(),
              Text(
                "9195",
                style: getRegularStyle(
                    color: Color(0xFF242E42), fontSize: FontSize.s16),
              ),
              30.05.pw
            ],
          ),
          25.96.ph
        ],
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 4,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(AppSize.s8), color: Colors.white),
    );
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
