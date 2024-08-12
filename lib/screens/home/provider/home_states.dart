import 'dart:async';

import 'package:laundryday/screens/home/model/timer_model.dart';

enum AppStates { initial, loading, loaded, error }

class HomeStates {
  int index;

  List<TimerModel>? onGoingOrderTimerList;
  Timer? timer;
  HomeStates({
    
    required this.index,
    this.onGoingOrderTimerList,
    this.timer,
  });

  HomeStates copyWith({
    int? index,
    List<TimerModel>? onGoingOrderTimerList,
   
    Timer? timer,
  }) {
    return HomeStates(
   
      index: index ?? this.index,
      onGoingOrderTimerList:
          onGoingOrderTimerList ?? this.onGoingOrderTimerList,
      timer: timer ?? this.timer,
    );
  }
}
