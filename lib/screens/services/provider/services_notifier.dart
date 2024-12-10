import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/models/order_list_model.dart';
import 'package:laundryday/models/order_model.dart';
import 'package:laundryday/repsositories/order_repository.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart';
import 'package:laundryday/screens/services/provider/services_states.dart';
import 'package:laundryday/repsositories/order_list_repository.dart';
import 'package:laundryday/screens/services/service/services_service.dart';
import 'package:laundryday/models/services_model.dart' as servicemodel;

final customerOrdersApi = Provider((ref) {
  return OrderListRepository();
});

final customerOrderProvider =
    FutureProvider.autoDispose<Either<String, OrderListModel>>((ref) async {
  final userModel = ref.read(userProvider).userModel;
  return await ref
      .read(customerOrdersApi)
      .customerOrders(userId: userModel!.user!.id!);
});

final pendingPickupRequestProvider =
    FutureProvider.autoDispose<Either<String, OrderListModel>>((ref) async {
  final userModel = ref.read(userProvider).userModel;
  return await ref
      .read(customerOrdersApi)
      .pendingPickupRequests(userId: userModel!.user!.id!);
});

final servicesApi = Provider((ref) {
  return ServicesService();
});

final servicesProvider =
    FutureProvider.autoDispose<Either<String, servicemodel.ServiceModel>>(
        (ref) async {
  return await ref.read(servicesApi).allService();
});

final serviceProvider = StateNotifierProvider<ServicesNotifier, ServicesStates>(
    (ref) => ServicesNotifier());
OrderRepository _orderRepository = OrderRepository();

class ServicesNotifier extends StateNotifier<ServicesStates> {
  servicemodel.ServiceModel servicesModel = servicemodel.ServiceModel();
  MyAddressModel? myAddressModel;

  ServicesNotifier() : super(ServicesStates(order: [])) {
    GoogleServices.getLocation();
  }

  selectedService({required servicemodel.Datum selectedService}) {
    state = state.copyWith(selectedService: selectedService);
  }

  pickupOrderRoundTrip(
      {required Map data,
      required WidgetRef ref,
      required BuildContext context}) async {
    BotToast.showLoading();
    Either<String, OrderModel> apiData =
        await _orderRepository.pickupOrderRoundTrip(
      data: data,
    );

    apiData.fold((l) {
      if (l == 'Not-Found') {
        l = 'Sorry There is no Delivery Agent in your Area. Try Again';

        BotToast.closeAllLoading();

        Utils.showReusableDialog(
            title: 'Operation Failed',
            description: l,
            buttons: [
              OutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('Ok'))
            ],
            context: context);
      } else {
        BotToast.closeAllLoading();

        Utils.showReusableDialog(
            title: 'Operation Failed',
            description: l,
            buttons: [
              OutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('Ok'))
            ],
            context: context);
      }
    }, (r) {
      BotToast.closeAllLoading();

      context.pushReplacementNamed(RouteNames.orderProcess,
          extra: r.order!.id!);
    });
  }

  pickupRequestUpdate(
      {required Map data,
      required WidgetRef ref,
      required BuildContext context}) async {
    BotToast.showLoading();
    Either<String, OrderModel> apiData =
        await _orderRepository.pickupRequestUpdate(
      data: data,
    );

    apiData.fold((l) {
      if (l == 'Not-Found') {
        l = 'Sorry There is no Delivery Agent in your Area. Try Again';

        BotToast.closeAllLoading();

        Utils.showReusableDialog(
            title: 'Operation Failed',
            description: l,
            buttons: [
              OutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('Ok'))
            ],
            context: context);
      } else {
        BotToast.closeAllLoading();

        Utils.showReusableDialog(
            title: 'Operation Failed',
            description: l,
            buttons: [
              OutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('Ok'))
            ],
            context: context);
      }
    }, (r) {
      context.pop();
      ref.invalidate(customerOrderProvider);
      ref.invalidate(pendingPickupRequestProvider);
      BotToast.closeAllLoading();

      // context.pushReplacementNamed(RouteNames.orderProcess,
      //     extra: r.order!.id!);
    });
  }
}
