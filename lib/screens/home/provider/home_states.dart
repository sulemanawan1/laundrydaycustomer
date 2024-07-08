import 'dart:async';

import 'package:laundryday/screens/home/model/order_model.dart';
import 'package:laundryday/screens/services/model/services_model.dart';
import 'package:laundryday/screens/home/model/timer_model.dart';
import 'package:laundryday/screens/services/provider/services_states.dart';

enum AppStates { initial, loading, loaded, error }

class HomeStates {
  int index;

  List<OrderModell> onGoingOrderList;
  List<TimerModel>? onGoingOrderTimerList;
  Timer? timer;
  HomeStates({
    
    required this.index,
    required this.onGoingOrderList,
    this.onGoingOrderTimerList,
    this.timer,
  });

  HomeStates copyWith({
    int? index,
    List<OrderModell>? onGoingOrderList,
    List<TimerModel>? onGoingOrderTimerList,
   
    Timer? timer,
  }) {
    return HomeStates(
   
      index: index ?? this.index,
      onGoingOrderList: onGoingOrderList ?? this.onGoingOrderList,
      onGoingOrderTimerList:
          onGoingOrderTimerList ?? this.onGoingOrderTimerList,
      timer: timer ?? this.timer,
    );
  }
}
