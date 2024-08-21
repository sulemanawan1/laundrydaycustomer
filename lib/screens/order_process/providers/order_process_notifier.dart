import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/screens/order_process/providers/order_process_states.dart';
import 'package:laundryday/screens/order_process/services/order_service.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart';

class OrderProcessNotifier extends StateNotifier<OrderProcessStates> {
  OrderProcessNotifier()
      : super(OrderProcessStates(
            countDownProgress: 0.0,
            remainingTime: Duration.zero,
            orderModel: OrderModel(),
            orderState: OrderStateInitialState()));

  OrderService _orderService = OrderService();

  updaterOrder({required OrderModel order}) {
    state = state.copyWith(orderModel: order);
  }

  getOrderDetail(
      {required int orderId,
      required WidgetRef ref,
      required BuildContext context}) async {
    try {
      state = state.copyWith(orderState: OrderStateInitialState());

      Either<String, OrderModel> apiData =
          await _orderService.getOrderDetail(orderId: orderId);

      apiData.fold((l) {
        state = state.copyWith(
            orderState: OrderStateErrorState(errorMessage: 'An Error Occured'));
        debugPrint(l);
      }, (r) {
        debugPrint(r.message);

        state =
            state.copyWith(orderState: OrderStateLoadedState(), orderModel: r);
      });
    } catch (e) {
      debugPrint(e.toString());

      state = state.copyWith(
          orderState: OrderStateErrorState(errorMessage: 'An Error Occured'));
    }
  }

 
}
