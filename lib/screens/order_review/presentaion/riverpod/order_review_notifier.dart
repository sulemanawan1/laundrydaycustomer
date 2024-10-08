import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart';
import 'package:laundryday/screens/order_review/data/order_repository.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/order_review_states.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

final orderReviewProvider =
    StateNotifierProvider.autoDispose<OrderReviewNotifier, OrderReviewStates>(
        (ref) => OrderReviewNotifier());

class OrderReviewNotifier extends StateNotifier<OrderReviewStates> {
  OrderRepository _orderRepository = OrderRepository();

  OrderReviewNotifier()
      : super(OrderReviewStates(
          deliveryTypes: [
            DelivertTypeModel(
                title: 'Drop & Pickup',
                description: 'From Home',
                deliveryType: 'drop_and_pickup_from_home',
                image: AssetImages.fromHome),
            DelivertTypeModel(
                title: 'Drop & Pickup',
                description: 'From Laundry',
                deliveryType: 'drop_and_pickup_from_store',
                image: AssetImages.fromLaundry),
          ],
          isLoading: false,
          items: [],
          isRecording: false,
          // total: 0.0,
        ));

  Future getAllItems() async {
    List<ItemVariation> items =
        await DatabaseHelper.instance.getAllItemVariations();

    items.removeWhere((item) => item.quantity == 0 || item.price == 0.0);

    state = state.copyWith(items: items);
  }

  selectDeliveryType({required DelivertTypeModel deliveryTypeModel}) {
    state = state.copyWith(selecteddeliveryType: deliveryTypeModel);
  }

  pickupOrder(
      {required Map data,
      required Map files,
      required WidgetRef ref,
      required BuildContext context}) async {
    state = state.copyWith(isLoading: true);
    Either<String, OrderModel> apiData =
        await _orderRepository.pickupOrder(data: data, files: files);

    apiData.fold((l) {
      state = state.copyWith(isLoading: false);

      if (l == 'Not-Found') {
        l = 'Sorry There is no Delivery Agent in your Area. Try Again';

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
      ref.invalidate(customerOrderProvider);
      context.pushReplacementNamed(RouteNames.orderProcess,
          extra: r.order!.id!);
      state = state.copyWith(isLoading: false);
    });
  }

  roundTripOrder(
      {required Map data,
      required WidgetRef ref,
      required BuildContext context}) async {
    state = state.copyWith(isLoading: true);

    Either<String, OrderModel> apiData = await _orderRepository.roundTripOrder(
      data: data,
    );

    apiData.fold((l) {
      state = state.copyWith(isLoading: false);

      if (l == 'Not-Found') {
        l = 'Sorry There is no Delivery Agent in your Area. Try Again';

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
      context.pushReplacementNamed(RouteNames.orderProcess,
          extra: r.order!.id!);
      state = state.copyWith(isLoading: false);
    });
  }
}
