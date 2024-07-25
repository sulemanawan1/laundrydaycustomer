import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/home/provider/home_notifier.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/font_manager.dart';
import 'package:laundryday/core/constants/sized_box.dart';

// ignore: must_be_immutable
class CircularTimerWidget extends ConsumerWidget {
  int index;
  CircularTimerWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerModel = ref.watch(homeProvider).onGoingOrderTimerList;

    return Column(
      children: [
        10.ph,
        SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            value: timerModel![index].progress,
            backgroundColor: ColorManager.primaryColorOpacity10,
            strokeWidth: 8,
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorManager.primaryColor),
          ),
        ),
        10.ph,
        Text(
          '${timerModel[index].remainingTime!.inHours.toString().padLeft(2, '0')}:${(timerModel[index].remainingTime!.inMinutes % 60).toString().padLeft(2, '0')}:${(timerModel[index].remainingTime!.inSeconds % 60).toString().padLeft(2, '0')}',
          style: GoogleFonts.poppins(
              color: ColorManager.primaryColor, fontSize: FontSize.s12,fontWeight:FontWeight.w600),
        ),
      ],
    );
  }
}
