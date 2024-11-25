import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:laundryday/constants/colors.dart';

class MyCarouselIndicator extends StatelessWidget {
  final int dotCount;
  final int position;
  final void Function(int)? onTap;

  MyCarouselIndicator(
      {super.key, this.onTap, required this.dotCount, required this.position});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DotsIndicator(
        dotsCount: dotCount,
        position: position,
        decorator: DotsDecorator(
          color: ColorManager.primaryColor,
          activeColor: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}
