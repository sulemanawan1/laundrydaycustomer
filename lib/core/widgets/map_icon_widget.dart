import 'package:flutter/material.dart';
import 'package:laundryday/core/constants/colors.dart';

// ignore: must_be_immutable
class MapIconWidget extends StatelessWidget {
  final void Function()? onTap;
  IconData? icon;
  MapIconWidget({super.key, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration:
             BoxDecoration(shape: BoxShape.circle, color: ColorManager.whiteColor),
        child: Center(child: Icon(icon ?? Icons.my_location,color: ColorManager. primaryColor,)),
      ),
    );
  }
}
