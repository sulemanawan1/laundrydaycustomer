import 'dart:async';

class TimerModel {
  DateTime? startTime;
  DateTime? endTime;
  Duration? remainingTime;
  double? progress = 0.0;

  TimerModel({
    this.startTime,
    this.endTime,
    this.remainingTime,
    this.progress,
  });

  TimerModel copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Duration? remainingTime,
    double? progress,
    Timer? timer,
  }) {
    return TimerModel(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      remainingTime: remainingTime ?? this.remainingTime,
      progress: progress ?? this.progress,
    );
  }
}



// DateTime startTime = DateTime.now();
// DateTime endTime =
//     DateTime.now().add(const Duration(days: 1)); // Set your end time here
// Duration remainingTime = const Duration();
// double progress;