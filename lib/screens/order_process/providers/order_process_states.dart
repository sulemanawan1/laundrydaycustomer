import 'package:laundryday/screens/order_review/data/models/order_model.dart';

class OrderProcessStates {
  OrderState orderState;
  OrderModel? orderModel;
  OrderProcessStates({required this.orderState, this.orderModel});

  OrderProcessStates copyWith(
      {OrderState? orderState, OrderModel? orderModel}) {
    return OrderProcessStates(
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
