import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/screens/order_process/components/pickup_order.dart';
import 'package:laundryday/screens/order_process/components/round_trip_order.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/services/pusher_service.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/screens/order_process/providers/order_process_notifier.dart';
import 'package:laundryday/screens/order_process/providers/order_process_states.dart';
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

    return PopScope(
      canPop: false, //When false, blocks the current route from being popped.
      onPopInvoked: (didpop) async {
        if (didpop) {
          return;
        }
        Future.delayed(Duration(seconds: 0), () {
          ref.invalidate(serviceProvider);

          context.goNamed(RouteNames.home);
        });
      },
      child: Scaffold(
          appBar: MyAppBar(
            onPressed: () {
              context.goNamed(RouteNames.home);
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
          )),
    );
  }

 
  
}

