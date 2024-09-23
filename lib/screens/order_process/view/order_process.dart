import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/payment_summary_widget.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/order_process/components/delivery_agent_detail_card.dart';
import 'package:laundryday/screens/order_process/components/four_digit_code_widget.dart';
import 'package:laundryday/screens/order_process/components/invoice_and_payment_button.dart';
import 'package:laundryday/screens/order_process/components/laundry_detail_button.dart';
import 'package:laundryday/screens/order_process/components/order_id_button.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/services/pusher_service.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/order_process/components/order_status_card.dart';
import 'package:laundryday/screens/order_process/providers/order_process_notifier.dart';
import 'package:laundryday/screens/order_process/providers/order_process_states.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/payment_method_nofifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

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

      PusherService(userModel: userModel!, ref: ref).initCLinet();
    });
  }

  @override
  Widget build(BuildContext context) {
    var orderState = ref.watch(orderProcessProvider).orderState;
    var orderModel = ref.watch(orderProcessProvider).orderModel;
    OrderType? orderType;
    if (orderState is OrderStateLoadedState) {
      orderType = getOrderType(orderType: orderModel.order!.type.toString());
    }

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
              if (orderType == OrderType.pickup)
                PickupOrder(orderModel: orderModel)
              else if (orderType == OrderType.roundTrip)
                RoundTripOrder(
                  orderModel: orderModel,
                )
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
    required this.countDownEnd,
    required this.countDownStart,
  });

  final DateTime countDownEnd;
  final DateTime countDownStart;

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
          countDownStart: widget.countDownEnd,
          countDownEnd: widget.countDownStart);

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        ref.read(countDownProvider.notifier).updateTimeRemaining(
            countDownStart: widget.countDownEnd,
            countDownEnd: widget.countDownStart);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = ref.watch(countDownProvider).remainingTime;
    final countDownProgress = ref.watch(countDownProvider).countDownProgress;

    return Column(
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

class PickupOrder extends ConsumerWidget {
  final OrderModel orderModel;
  const PickupOrder({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider).userModel;

    return Column(
      children: [
        10.85.ph,
        StatusImage(status: orderModel.order!.status!),
        25.ph,
        OrderStatuesCard(
          type: orderModel.order!.type!,
          status: orderModel.order!.status!,
          orderStatuses: orderModel.order!.orderStatuses!,
          countDownStart: orderModel.order?.countDownStart,
          countDownEnd: orderModel.order?.countDownEnd,
        ),
        10.ph,
        if (orderModel.order!.status ==
            getPickupStatus(orderStatus: OrderStatusesList.atCustomer)) ...[
          FourDigitCode(code: orderModel.order!.code!)
        ],
        LaundryDetailButton(
          branchName: orderModel.order!.branchName!,
          totalItems: orderModel.order!.totalItems!,
        ),
        10.ph,
        OrderIdButton(orderId: orderModel.order!.id!),
        10.ph,
        if (orderModel.order!.paymentStatus == PaymentStatuses.unpaid.name) ...[
          InvoiceAndPaymentButton(orderModel: orderModel),
        ],
        15.ph,
        if (orderModel.order?.orderDeliveries != null) ...[
          DeliveryAgentCard(
            ref: ref,
              userModel: user!,
              orderDeliveries: orderModel.order!.orderDeliveries!),
        ],
        35.ph,
        // SizedBox(
        //   height: 200,
        //   child: GoogleMap(
        //     // ignore: prefer_collection_literals
        //     gestureRecognizers: Set()
        //       ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
        //       ..add(Factory<ScaleGestureRecognizer>(
        //           () => ScaleGestureRecognizer()))
        //       ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
        //       ..add(Factory<VerticalDragGestureRecognizer>(
        //           () => VerticalDragGestureRecognizer())),
        //     markers: {
        //       Marker(
        //         markerId: const MarkerId('You'),
        //         position: LatLng(
        //           currentLocation.latitude!,
        //           currentLocation.longitude!,
        //         ),
        //         icon: youIcon,
        //         infoWindow: const InfoWindow(title: 'You'),
        //       ),
        //       Marker(
        //         markerId: const MarkerId('Agent'),
        //         position: LatLng(
        //           orderModel.order!.orderDeliveries.deliveryAgent.!,
        //           orderModel.order!.customerLng!,
        //         ),
        //         icon: customerIcon,
        //         infoWindow: const InfoWindow(title: 'Customer'),
        //       ),
        //       Marker(
        //         markerId: const MarkerId('store'),
        //         position: LatLng(
        //           orderModel.order!.branchLat!,
        //           orderModel.order!.branchLng!,
        //         ),
        //         icon: storeIcon,
        //         infoWindow: const InfoWindow(title: 'Store'),
        //       ),
        //     },
        //     initialCameraPosition: CameraPosition(
        //         zoom: 14,
        //         target: LatLng(
        //           orderModel.order!.branchLat!,
        //           orderModel.order!.branchLng!,
        //         )),
        //     compassEnabled: false,
        //     myLocationEnabled: true,
        //     zoomControlsEnabled: false,
        //     myLocationButtonEnabled: false,
        //     mapToolbarEnabled: false,
        //     onMapCreated: (GoogleMapController gcontroller) {
        //       ref.read(orderProcessProvider.notifier).mapController =
        //           gcontroller;
        //     },
        //   ),
        // ),
      ],
    );
  }
}

class RoundTripOrder extends ConsumerWidget {
  final OrderModel orderModel;

  const RoundTripOrder({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPaymentMethod =
        ref.watch(PaymentMethodProvider).selectedPaymentMethod;
    final user = ref.read(userProvider).userModel;

    return Column(
      children: [
        10.85.ph,
        StatusImage(status: orderModel.order!.status!),
        25.ph,
        OrderStatuesCard(
          firstTripStatus: orderModel.order!.firstTripStatus,
          secondTripStatus: orderModel.order!.secondTripStatus,
          type: orderModel.order!.type!,
          status: orderModel.order!.status!,
          orderStatuses: orderModel.order!.orderStatuses!,
          countDownStart: orderModel.order?.countDownStart,
          countDownEnd: orderModel.order?.countDownEnd,
        ),
        10.ph,
        if (orderModel.order!.status == "delivering-to-store") ...[
          GestureDetector(
            onTap: () {
              context.pushNamed(RouteNames.viewNetworkImage,
                  extra: Api.imageUrl +
                      orderModel.order!.pickupInvoice!.toString());
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
                      'Pickup Invoice',
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
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.ph,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        21.ph,
                        PaymentSummaryText(
                            text1: 'Delivery Fee',
                            text2: (orderModel.order!.operationFee! +
                                    orderModel.order!.deliveryFee!)
                                .toString()),
                        PaymentSummaryText(
                            text1: 'Item Cost',
                            text2: orderModel.order!.itemTotalPrice.toString()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',
                                  style: getSemiBoldStyle(
                                      fontSize: 14, color: Color(0xFF818181))),
                              Text(
                                '${orderModel.order!.totalPrice.toString()} SAR',
                                style: getSemiBoldStyle(
                                  color: Color(0xFF242424),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        21.ph,
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFF9F9F9)),
                  ),
                  5.ph,
                  const Heading(title: "Payment Method"),
                  10.ph,
                  InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        isDismissible: false,
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8))),
                        builder: (BuildContext context) {
                          return Consumer(builder: (context, reff, child) {
                            final paymentMethods =
                                reff.read(PaymentMethodProvider).paymentMethods;
                            final selectedPaymentMethod = reff
                                .watch(PaymentMethodProvider)
                                .selectedPaymentMethod;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  10.ph,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      HeadingMedium(
                                          title: 'Choose payment method'),
                                      IconButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: ColorManager.greyColor,
                                          ))
                                    ],
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      separatorBuilder: ((context, index) =>
                                          18.ph),
                                      itemCount: paymentMethods.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        print(
                                            "Selected ${selectedPaymentMethod.name}");
                                        print(
                                            "List ${paymentMethods[index].name}");
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: ColorManager
                                                      .primaryColor)),
                                          child: ListTile(
                                            onTap: () {
                                              reff
                                                  .read(PaymentMethodProvider
                                                      .notifier)
                                                  .selectIndex(
                                                      selectedPaymentMethod:
                                                          paymentMethods[
                                                              index]);
                                            },
                                            trailing: Image.asset(
                                              paymentMethods[index]
                                                  .icon
                                                  .toString(),
                                              height: 20,
                                            ),
                                            leading: Wrap(children: [
                                              (selectedPaymentMethod.name ==
                                                      paymentMethods[index]
                                                          .name)
                                                  ? Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      color: ColorManager
                                                          .primaryColor,
                                                    )
                                                  : const Icon(
                                                      Icons.circle_outlined),
                                              10.pw,
                                              Heading(
                                                  title: paymentMethods[index]
                                                      .name
                                                      .toString())
                                            ]),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  5.ph,
                                  MyButton(
                                    isBorderButton: true,
                                    widget: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add_circle_outline),
                                        5.pw,
                                        Text(
                                          'Add New Debit/Credit',
                                          style: getSemiBoldStyle(
                                            color: ColorManager.primaryColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    )),
                                    title: '',
                                    onPressed: () {
                                      context.pushNamed(RouteNames.addNewCard);
                                    },
                                  ),
                                  10.ph,
                                  MyButton(
                                    title: 'Select Method',
                                    onPressed: () {
                                      context.pop();
                                    },
                                  ),
                                  20.ph
                                ],
                              ),
                            );
                          });
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              selectedPaymentMethod.icon,
                              width: 50,
                              height: 20,
                            ),
                            10.pw,
                            HeadingMedium(title: selectedPaymentMethod.name)
                          ],
                        ),
                        const Spacer(),
                        Heading(
                          color: ColorManager.primaryColor,
                          title: 'Change',
                        )
                      ],
                    ),
                  ),
                  10.ph,
                ],
              ),
            ),
          ),
          70.ph,
          selectedPaymentMethod.name == 'apple pay'
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: ColorManager.blackColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Pay with',
                            style: getSemiBoldStyle(
                              color: ColorManager.whiteColor,
                              fontSize: 14,
                            ),
                          ),
                          5.pw,
                          Image.asset(
                            'assets/icons/apple_pay.png',
                            color: ColorManager.whiteColor,
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyButton(
                    title: 'pay',
                    onPressed: () {
                      OrderStatus orderStatus = orderModel.order!.orderStatuses!
                          .firstWhere(
                              orElse: () => OrderStatus(),
                              (e) =>
                                  e.status ==
                                      'payment-collected-not-assigned' &&
                                  e.type == 'delivery-to-store');

                      Map data = {
                        "order_id": orderModel.order!.id,
                        "order_status_id": orderStatus.id,
                        "delivery_agent_id":
                            orderModel.order!.orderDeliveries!.deliveryAgentId
                      };

                      log(orderModel.order!.id.toString());
                      log(orderStatus.id.toString());

                      ref.read(orderProcessProvider.notifier).paymentCollected(
                          data: data, context: context, ref: ref);
                    },
                  ),
                )
        ] else ...[
          if (orderModel.order!.status ==
              getPickupStatus(orderStatus: OrderStatusesList.atCustomer)) ...[
            FourDigitCode(code: orderModel.order!.code!)
          ],
          LaundryDetailButton(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: ColorManager.whiteColor,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          10.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.blackColor,
                                    fontSize: 18,
                                  )),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: ColorManager.whiteColor,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                    onPressed: () {
                                      GoRouter.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: ColorManager.greyColor,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            branchName: orderModel.order!.branchName!,
            totalItems: orderModel.order!.totalItems!,
          ),
          10.ph,
          OrderIdButton(orderId: orderModel.order!.id!),
          10.ph,
          if (orderModel.order!.status == 'delivering-to-store') ...[
            InvoiceAndPaymentButton(orderModel: orderModel),
          ],
          15.ph,
          if (orderModel.order?.orderDeliveries != null) ...[
            DeliveryAgentCard(
              ref: ref,
                userModel: user!,
                orderDeliveries: orderModel.order!.orderDeliveries!),
          ],
          35.ph,
        ]
      ],
    );
  }
}
