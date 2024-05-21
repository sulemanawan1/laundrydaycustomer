import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/models/order_invoice_model.dart';
import 'package:laundryday/models/order_status.dart';
import 'package:laundryday/screens/home/model/order_model.dart';
import 'package:laundryday/screens/home/model/timer_model.dart';
import 'package:laundryday/screens/home/provider/home_states.dart';
import 'package:laundryday/screens/laundries/model/services_timings_model.dart';

final homeProvider =
    StateNotifierProvider<HomeNotifier, HomeStates>((ref) => HomeNotifier());

class HomeNotifier extends StateNotifier<HomeStates> {
  HomeNotifier()
      : super(HomeStates(
            onGoingOrderTimerList: [],
            index: 0,
            onGoingOrderList: [
              OrderModell(
                  itemTotalCharges: 0.0,
                  profit: 14,
                  total: 50,
                  servicesTimingModel: ServicesTimingModel(
                      duration: 1,
                      type: 'day',
                      description: '24-hours Service',
                      id: 1,
                      name: 'Normal',
                      img: 'assets/icons/24-hour-service.png'),
                  startTime: DateTime.now(),
                  endTime: DateTime.now().add(const Duration(hours: 1)),
                  orderId: 113344,
                  paymentMethod: 'Stc Pay',
                  status: 'accepted order',
                  type: 'two-trip',
                  items: [
                    ItemModel(
                        image: 'assets/images/Guthra.png',
                        id: 10,
                        name: 'Guthra Red',
                        quantity: 2,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 12),
                    ItemModel(
                        image: 'assets/images/Guthra.png',
                        id: 11,
                        name: 'Guthra White',
                        quantity: 3,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 12),
                    ItemModel(
                        image: 'assets/images/Thobe.png',
                        id: 12,
                        name: 'Thobe',
                        quantity: 4,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 11),
                    ItemModel(
                        image: 'assets/images/Medical Trouser.png',
                        id: 14,
                        name: 'Medical Trouser',
                        quantity: 6,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 3,
                        serviceId: 1,
                        blanketItemId: 26),
                    ItemModel(
                        image: 'assets/images/Lap Coat.png',
                        id: 15,
                        name: 'Lab Coat',
                        quantity: 3,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 3,
                        serviceId: 1,
                        blanketItemId: 26),
                    ItemModel(
                        image: 'assets/images/Coveralll.png',
                        id: 16,
                        name: 'Security Uniform',
                        quantity: 4,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 2,
                        serviceId: 1,
                        blanketItemId: 25),
                    ItemModel(
                        image: 'assets/images/Coveralll.png',
                        id: 17,
                        name: 'Army Uniform',
                        quantity: 6,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 2,
                        serviceId: 1,
                        blanketItemId: 25),
                  ],
                  orderStatus: [
                    // OrderStatusModel(
                    //   id: 1,
                    //   description: 'pending',
                    //   orderId: 113344,
                    //   status: 0,
                    //   isActive: true,
                    //   createdAt: DateTime.now(),
                    // ),
                    OrderStatusModel(
                      id: 2,
                      description: 'accepted',
                      orderId: 113344,
                      status: 0,
                      isActive: true,
                      createdAt:
                          DateTime.now().add(const Duration(minutes: 10)),
                    ),
                    OrderStatusModel(
                      id: 3,
                      description: 'approach-you',
                      orderId: 113344,
                      status: 0,
                      isActive: true,
                      createdAt:
                          DateTime.now().add(const Duration(minutes: 10)),
                    ),
                    OrderStatusModel(
                      id: 4,
                      description: 'invoice-created',
                      orderId: 113344,
                      status: 0,
                      isActive: true,
                      createdAt:
                          DateTime.now().add(const Duration(minutes: 15)),
                    ),
                    OrderStatusModel(
                      id: 5,
                      description: 'order-pickup',
                      orderId: 113344,
                      status: 0,
                      isActive: false,
                      createdAt: DateTime.now().add(const Duration(minutes: 3)),
                    ),
                    OrderStatusModel(
                      id: 5,
                      description: 'approach-you2',
                      orderId: 113344,
                      status: 0,
                      isActive: false,
                      createdAt: DateTime.now().add(const Duration(minutes: 7)),
                    ),
                    OrderStatusModel(
                      id: 6,
                      description: 'order-delivered',
                      orderId: 113344,
                      status: 0,
                      isActive: false,
                      createdAt: DateTime.now().add(const Duration(minutes: 7)),
                    ),
                  ],
                  invoice: OrderInvoiceModel(
                      id: 1, amount: 10.0, image: '', orderId: 113344)),
              OrderModell(
                  itemTotalCharges: 0.0,
                  servicesTimingModel: ServicesTimingModel(
                      duration: 1,
                      type: 'hour',
                      description: '1 hour Service',
                      id: 2,
                      name: 'Quick',
                      img: 'assets/icons/rush.png'),
                  startTime: DateTime.now(),
                  endTime: DateTime.now().add(const Duration(hours: 1)),
                  orderId: 114444,
                  paymentMethod: 'Stc Pay',
                  total: 30.0,
                  profit: 14.0,
                  status: 'accepted order',
                  type: 'two-trip',
                  items: [
                    ItemModel(
                        image: 'assets/images/Guthra.png',
                        id: 10,
                        name: 'Guthra Red',
                        quantity: 2,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 12),
                    ItemModel(
                        image: 'assets/images/Guthra.png',
                        id: 11,
                        name: 'Guthra White',
                        quantity: 3,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 12),
                    ItemModel(
                        image: 'assets/images/Thobe.png',
                        id: 12,
                        name: 'Thobe',
                        quantity: 4,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 11),
                    ItemModel(
                        image: 'assets/images/Medical Trouser.png',
                        id: 14,
                        name: 'Medical Trouser',
                        quantity: 6,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 3,
                        serviceId: 1,
                        blanketItemId: 26),
                    ItemModel(
                        image: 'assets/images/Lap Coat.png',
                        id: 15,
                        name: 'Lab Coat',
                        quantity: 3,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 3,
                        serviceId: 1,
                        blanketItemId: 26),
                    ItemModel(
                        image: 'assets/images/Coveralll.png',
                        id: 16,
                        name: 'Security Uniform',
                        quantity: 4,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 2,
                        serviceId: 1,
                        blanketItemId: 25),
                    ItemModel(
                        image: 'assets/images/Coveralll.png',
                        id: 17,
                        name: 'Army Uniform',
                        quantity: 6,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 2,
                        serviceId: 1,
                        blanketItemId: 25),
                  ],
                  orderStatus: [
                    // OrderStatusModel(
                    //   id: 1,
                    //   description: 'pending',
                    //   orderId: 114444,
                    //   status: 0,
                    //   isActive: true,
                    //   createdAt: DateTime.now(),
                    // ),
                    OrderStatusModel(
                      id: 2,
                      description: 'accepted',
                      orderId: 114444,
                      status: 0,
                      isActive: true,
                      createdAt:
                          DateTime.now().add(const Duration(minutes: 10)),
                    ),
                    OrderStatusModel(
                      id: 3,
                      description: 'approach-you',
                      orderId: 114444,
                      status: 0,
                      isActive: true,
                      createdAt:
                          DateTime.now().add(const Duration(minutes: 10)),
                    ),
                    OrderStatusModel(
                      id: 4,
                      description: 'invoice-created',
                      orderId: 114444,
                      status: 0,
                      isActive: true,
                      createdAt:
                          DateTime.now().add(const Duration(minutes: 15)),
                    ),
                    OrderStatusModel(
                      id: 5,
                      description: 'order-pickup',
                      orderId: 114444,
                      status: 0,
                      isActive: true,
                      createdAt: DateTime.now().add(const Duration(minutes: 3)),
                    ),
                    OrderStatusModel(
                      id: 5,
                      description: 'approach-you2',
                      orderId: 114444,
                      status: 0,
                      isActive: false,
                      createdAt: DateTime.now().add(const Duration(minutes: 7)),
                    ),
                    OrderStatusModel(
                      id: 6,
                      description: 'order-delivered',
                      orderId: 114444,
                      status: 0,
                      isActive: false,
                      createdAt: DateTime.now().add(const Duration(minutes: 7)),
                    ),
                  ],
                  invoice: OrderInvoiceModel(
                      id: 1, amount: 10.0, image: '', orderId: 114444)),
              OrderModell(
                  itemTotalCharges: 0.0,
                  servicesTimingModel: ServicesTimingModel(
                      duration: 5,
                      type: 'day',
                      description: '1 hour Service',
                      id: 2,
                      name: 'Quick',
                      img: 'assets/icons/rush.png'),
                  startTime: DateTime.now(),
                  endTime: DateTime.now().add(const Duration(days: 5)),
                  orderId: 114488,
                  paymentMethod: 'Stc Pay',
                  total: 30.0,
                  profit: 14.0,
                  status: 'accepted order',
                  type: 'two-trip',
                  items: [
                    ItemModel(
                        image: 'assets/images/Guthra.png',
                        id: 10,
                        name: 'Guthra Red',
                        quantity: 2,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 12),
                    ItemModel(
                        image: 'assets/images/Guthra.png',
                        id: 11,
                        name: 'Guthra White',
                        quantity: 3,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 12),
                    ItemModel(
                        image: 'assets/images/Thobe.png',
                        id: 12,
                        name: 'Thobe',
                        quantity: 4,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 11),
                    ItemModel(
                        image: 'assets/images/Medical Trouser.png',
                        id: 14,
                        name: 'Medical Trouser',
                        quantity: 6,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 3,
                        serviceId: 1,
                        blanketItemId: 26),
                    ItemModel(
                        image: 'assets/images/Lap Coat.png',
                        id: 15,
                        name: 'Lab Coat',
                        quantity: 3,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 3,
                        serviceId: 1,
                        blanketItemId: 26),
                    ItemModel(
                        image: 'assets/images/Coveralll.png',
                        id: 16,
                        name: 'Security Uniform',
                        quantity: 4,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 2,
                        serviceId: 1,
                        blanketItemId: 25),
                    ItemModel(
                        image: 'assets/images/Coveralll.png',
                        id: 17,
                        name: 'Army Uniform',
                        quantity: 6,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 2,
                        serviceId: 1,
                        blanketItemId: 25),
                  ],
                  orderStatus: [
                    // OrderStatusModel(
                    //   id: 1,
                    //   description: 'pending',
                    //   orderId: 114444,
                    //   status: 0,
                    //   isActive: true,
                    //   createdAt: DateTime.now(),
                    // ),
                    OrderStatusModel(
                      id: 2,
                      description: 'accepted',
                      orderId: 114488,
                      status: 0,
                      isActive: true,
                      createdAt:
                          DateTime.now().add(const Duration(minutes: 10)),
                    ),
                    OrderStatusModel(
                      id: 3,
                      description: 'approach-you',
                      orderId: 114488,
                      status: 0,
                      isActive: true,
                      createdAt:
                          DateTime.now().add(const Duration(minutes: 10)),
                    ),
                    OrderStatusModel(
                      id: 4,
                      description: 'invoice-created',
                      orderId: 114488,
                      status: 0,
                      isActive: true,
                      createdAt:
                          DateTime.now().add(const Duration(minutes: 15)),
                    ),
                    OrderStatusModel(
                      id: 5,
                      description: 'order-pickup',
                      orderId: 114488,
                      status: 0,
                      isActive: true,
                      createdAt: DateTime.now().add(const Duration(minutes: 3)),
                    ),
                    OrderStatusModel(
                      id: 5,
                      description: 'approach-you2',
                      orderId: 114488,
                      status: 0,
                      isActive: true,
                      createdAt: DateTime.now().add(const Duration(minutes: 7)),
                    ),
                    OrderStatusModel(
                      id: 6,
                      description: 'order-delivered',
                      orderId: 114488,
                      status: 0,
                      isActive: false,
                      createdAt: DateTime.now().add(const Duration(minutes: 7)),
                    ),
                  ],
                  invoice: OrderInvoiceModel(
                      id: 1, amount: 10.0, image: '', orderId: 114488)),
              OrderModell(
                  itemTotalCharges: 0.0,
                  servicesTimingModel: null,
                  pickupRecipt: 'assets/images/invoice.png',
                  startTime: DateTime.now(),
                  endTime: DateTime.now().add(const Duration(hours: 1)),
                  orderId: 112244,
                  paymentMethod: 'Stc Pay',
                  profit: 20.0,
                  total: 40.0,
                  status: 'accepted order',
                  type: 'pickup',
                  items: [
                    ItemModel(
                        image: 'assets/images/Guthra.png',
                        id: 10,
                        name: 'Guthra Red',
                        quantity: 2,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 12),
                    ItemModel(
                        image: 'assets/images/Guthra.png',
                        id: 11,
                        name: 'Guthra White',
                        quantity: 3,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 12),
                    ItemModel(
                        image: 'assets/images/Thobe.png',
                        id: 12,
                        name: 'Thobe',
                        quantity: 4,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 1,
                        serviceId: 1,
                        blanketItemId: 11),
                    ItemModel(
                        image: 'assets/images/Medical Trouser.png',
                        id: 14,
                        name: 'Medical Trouser',
                        quantity: 6,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 3,
                        serviceId: 1,
                        blanketItemId: 26),
                    ItemModel(
                        image: 'assets/images/Lap Coat.png',
                        id: 15,
                        name: 'Lab Coat',
                        quantity: 3,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 3,
                        serviceId: 1,
                        blanketItemId: 26),
                    ItemModel(
                        image: 'assets/images/Coveralll.png',
                        id: 16,
                        name: 'Security Uniform',
                        quantity: 4,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 2,
                        serviceId: 1,
                        blanketItemId: 25),
                    ItemModel(
                        image: 'assets/images/Coveralll.png',
                        id: 17,
                        name: 'Army Uniform',
                        quantity: 6,
                        initialCharges: 4,
                        charges: 4,
                        category: 'clothes',
                        categoryId: 2,
                        serviceId: 1,
                        blanketItemId: 25),
                  ],
                  orderStatus: [
                    // OrderStatusModel(
                    //   id: 2,
                    //   description: 'accepted',
                    //   orderId: 112244,
                    //   status: 0,
                    //   isActive: false,
                    //   createdAt:
                    //       DateTime.now().add(const Duration(minutes: 10)),
                    // ),
                    OrderStatusModel(
                      id: 5,
                      description: 'order-pickup',
                      orderId: 112244,
                      status: 0,
                      isActive: false,
                      createdAt: DateTime.now().add(const Duration(minutes: 3)),
                    ),
                    OrderStatusModel(
                      id: 3,
                      description: 'approach-you',
                      orderId: 112244,
                      status: 0,
                      isActive: false,
                      createdAt:
                          DateTime.now().add(const Duration(minutes: 10)),
                    ),
                    OrderStatusModel(
                        id: 6,
                        description: 'order-delivered',
                        orderId: 112244,
                        status: 0,
                        isActive: false,
                        createdAt: null),
                  ],
                  invoice: OrderInvoiceModel(
                      id: 1, amount: 10.0, image: '', orderId: 112244))
            ])) {
    assigningOnGoingOrderTimerList();
  }

  assigningOnGoingOrderTimerList() {
    for (int i = 0; i < state.onGoingOrderList.length; i++) {
      if (state.onGoingOrderList[i].servicesTimingModel != null) {
        if (state.onGoingOrderList[i].servicesTimingModel!.type == 'day') {
          state.onGoingOrderTimerList!.add(TimerModel(
              startTime: DateTime.now(),
              endTime: DateTime.now().add(Duration(
                  days:
                      state.onGoingOrderList[i].servicesTimingModel!.duration)),
              remainingTime: const Duration(),
              progress: 0.0));
        } else {
          state.onGoingOrderTimerList!.add(TimerModel(
              startTime: DateTime.now(),
              endTime: DateTime.now().add(Duration(
                  hours:
                      state.onGoingOrderList[i].servicesTimingModel!.duration)),
              remainingTime: const Duration(),
              progress: 0.0));
        }
      }
    }

    state = state.copyWith(onGoingOrderTimerList: state.onGoingOrderTimerList);
  }

  void startOnGoingOrderTimer() {
    state.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        for (int i = 0; i < state.onGoingOrderTimerList!.length; i++) {
          log(state.onGoingOrderTimerList![i].remainingTime.toString());

          state.onGoingOrderTimerList![i].remainingTime = state
              .onGoingOrderTimerList![i].endTime!
              .difference(DateTime.now());
          if (state.onGoingOrderTimerList![i].remainingTime!.isNegative) {
            timer.cancel();

            state.onGoingOrderTimerList![i].remainingTime = const Duration();
            state.onGoingOrderTimerList![i].progress = 1.0;
            state = state.copyWith(
                onGoingOrderTimerList: state.onGoingOrderTimerList);
          } else {
            state.onGoingOrderTimerList![i].progress = 1.0 -
                (state.onGoingOrderTimerList![i].remainingTime!.inSeconds /
                    (state.onGoingOrderTimerList![i].endTime!.difference(
                            state.onGoingOrderTimerList![i].startTime!))
                        .inSeconds);
          }

          state = state.copyWith(
              onGoingOrderTimerList: state.onGoingOrderTimerList);
        }
      }
    });
  }
}
