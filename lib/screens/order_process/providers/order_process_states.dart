import 'package:laundryday/models/chat_profile_model.dart';
import 'package:laundryday/models/order_model.dart';

class OrderProcessStates {
  OrderState orderState;
  Duration remainingTime;
  double countDownProgress;
  OrderModel orderModel;

  ChatProfileModel? chatProfileModel;

  OrderProcessStates(
      {required this.countDownProgress,
      required this.orderState,
      required this.orderModel,
      required this.remainingTime,
      this.chatProfileModel,
   });

  OrderProcessStates copyWith(
      {double? countDownProgress,
      OrderState? orderState,
      OrderModel? orderModel,
      Duration? remainingTime,
        ChatProfileModel? chatProfileModel

      }) {
    return OrderProcessStates(
      chatProfileModel: chatProfileModel??this.chatProfileModel,
        countDownProgress: countDownProgress ?? this.countDownProgress,
        remainingTime: remainingTime ?? this.remainingTime,
        orderModel: orderModel ?? this.orderModel,
        orderState: orderState ?? this.orderState);
  }
}

abstract class OrderState {}

class OrderStateInitialState extends OrderState {}

class OrderStateLoadingState extends OrderState {}

class OrderStateLoadedState extends OrderState {
  OrderStateLoadedState();
}

class OrderStateErrorState extends OrderState {
  final String errorMessage;
  OrderStateErrorState({required this.errorMessage});
}
