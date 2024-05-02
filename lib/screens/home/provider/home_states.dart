import 'package:laundryday/screens/home/model/order_model.dart';

class HomeStates {
  int index;
  List<OrderModell> onGoingOrderList;
  HomeStates({
    required this.index,
    required this.onGoingOrderList,
  });

  HomeStates copyWith({
    int? index,
    List<OrderModell>? onGoingOrderList,
  }) {
    return HomeStates(
      index: index ?? this.index,
      onGoingOrderList: onGoingOrderList ?? this.onGoingOrderList,
    );
  }
}
