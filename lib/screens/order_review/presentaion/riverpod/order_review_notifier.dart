import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/order_review/data/models/order_model.dart';
import 'package:laundryday/screens/order_review/data/order_repository.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/order_review_states.dart';

final orderReviewProvider =
    StateNotifierProvider.autoDispose<OrderReviewNotifier, OrderReviewStates>(
        (ref) => OrderReviewNotifier());

class OrderReviewNotifier extends StateNotifier<OrderReviewStates> {
  OrderRepository _orderRepository = OrderRepository();
  OrderReviewNotifier()
      : super(OrderReviewStates(
          items: [],
          isRecording: false,
          isPaid: false,
          total: 0.0,
        ));

  Future getAllItems() async {
    List<ItemVariation> items =
        await DatabaseHelper.instance.getAllItemVariations();

    items.removeWhere((item) => item.quantity == 0 || item.price == 0.0);

    state = state.copyWith(items: items);
  }

  pickupOrder(
      {required Map data,
      required Map files,
      required WidgetRef ref,
      required BuildContext context}) async {
    Either<String, OrderModel> apiData =
        await _orderRepository.pickupOrder(data: data, files: files);

    apiData.fold((l) {
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
    });
  }
}
