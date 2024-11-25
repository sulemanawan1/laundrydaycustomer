import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';

class CounDownStates {
  Duration remainingTime;
  double countDownProgress;

  CounDownStates({
    required this.countDownProgress,
    required this.remainingTime,
  });

  CounDownStates copyWith(
      {Duration? remainingTime, double? countDownProgress}) {
    return CounDownStates(
      countDownProgress: countDownProgress ?? this.countDownProgress,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }
}

final countDownProvider =
    StateNotifierProvider<CountDownStateNotifer, CounDownStates>(
        (ref) => CountDownStateNotifer());

class CountDownStateNotifer extends StateNotifier<CounDownStates> {
  CountDownStateNotifer()
      : super(CounDownStates(
            countDownProgress: 0.0, remainingTime: Duration.zero));

  void updateTimeRemaining(
      {required DateTime countDownStart, required DateTime countDownEnd}) {
    print(countDownEnd);
    final now = DateTime.now();
    if (countDownStart.isAfter(now)) {
      state.remainingTime = countDownStart.difference(now);

      state.countDownProgress = 1.0 -
          state.remainingTime.inSeconds /
              (countDownStart.difference(countDownEnd).inSeconds);

      print(state.countDownProgress);

      state = state.copyWith(
          remainingTime: state.remainingTime,
          countDownProgress: state.countDownProgress);
    } else {
      state.remainingTime = Duration.zero;
      state.countDownProgress = 0.0;
      state = state.copyWith(
          remainingTime: state.remainingTime,
          countDownProgress: state.countDownProgress);
    }
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class TimerWidget extends ConsumerStatefulWidget {
  TimerWidget({
    super.key,
    required this.countDownEnd,
    required this.countDownStart,
  });

  final DateTime countDownEnd;
  final DateTime countDownStart;

  @override
  ConsumerState<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends ConsumerState<TimerWidget> {
  late Timer timer;

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      ref.read(countDownProvider.notifier).updateTimeRemaining(
          countDownStart: widget.countDownEnd,
          countDownEnd: widget.countDownStart);

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        ref.read(countDownProvider.notifier).updateTimeRemaining(
            countDownStart: widget.countDownEnd,
            countDownEnd: widget.countDownStart);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = ref.watch(countDownProvider).remainingTime;
    final countDownProgress = ref.watch(countDownProvider).countDownProgress;

    return Column(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            value: countDownProgress,
            backgroundColor: ColorManager.nprimaryColor.withOpacity(0.2),
            strokeWidth: 5.0,
            color: ColorManager.nprimaryColor,
          ),
        ),
        9.ph,
        Text(
          ref.read(countDownProvider.notifier).formatDuration(remainingTime),
          style: getRegularStyle(color: ColorManager.blackColor, fontSize: 8),
        )
      ],
    );
  }
}
