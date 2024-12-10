import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/constants/assets_manager.dart';
import 'package:laundryday/models/order_model.dart';
import 'package:laundryday/models/order_summary_model.dart';
import 'package:laundryday/repsositories/order_summary_repository.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/order_review/data/models/payment_option_model.dart';
import 'package:laundryday/repsositories/order_repository.dart';
import 'package:laundryday/screens/order_review/presentaion/riverpod/order_review_states.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/shared/provider/user_notifier.dart';

final orderSummaryRepoProvider = Provider((ref) {
  return OrderSummaryRepository();
});

final orderSumaryProvder =
    FutureProvider.autoDispose<Either<String, OrderSummaryModel>>((ref) async {
  final userModel = ref.read(userProvider).userModel;
  return await ref.read(orderSummaryRepoProvider).calculate(data: {
    // pickup_only_from_store
    "code": "20%OFF",
    "order_type": "drop_and_pickup_from_store",
    "user_id": 4,
    "distance": 3000,
    "items": [
      {"item_variation_id": 1, "price": 10.1, "quantity": 10},
      {"item_variation_id": 1, "price": 10, "quantity": 4}
    ]
  });
});

final orderReviewProvider =
    StateNotifierProvider.autoDispose<OrderReviewNotifier, OrderReviewStates>(
        (ref) {
  return OrderReviewNotifier();
});

class OrderReviewNotifier extends StateNotifier<OrderReviewStates> {
  OrderRepository _orderRepository = OrderRepository();

  OrderReviewNotifier()
      : super(OrderReviewStates(
          paymentOptions: [
            PaymentOptionModel(title: 'Yes Paid', paymentOption: 'pay_now'),
            PaymentOptionModel(title: 'Not Paid', paymentOption: 'pay_later'),
          ],
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
          
        )) {}

  Future getAllItems() async {
    List<ItemVariation> items =
        await DatabaseHelper.instance.getAllItemVariations();

    items.removeWhere((item) => item.quantity == 0 || item.price == 0.0);

    state = state.copyWith(items: items);
  }

  selectDeliveryType({required DelivertTypeModel deliveryTypeModel}) {
    state = state.copyWith(selecteddeliveryType: deliveryTypeModel);
  }

  // calculate(
  //     {required Map data,
  //     required WidgetRef ref,
  //    }) async {

  //   Either<String, OrderSummaryModel> apiData =
  //       await _orderSummaryRepository.calculate(data: data);

  //   apiData.fold((l) {}, (r) {
  //     log(r.data!.deliveryFees.toString());
  //   });
  // }

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

  selectPaymentOption({required PaymentOptionModel selectedPaymentOption}) {
    state = state.copyWith(selectedPaymentOption: selectedPaymentOption);
  }
}
