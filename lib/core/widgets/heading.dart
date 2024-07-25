import 'package:flutter/material.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/font_manager.dart';
import 'package:laundryday/core/theme/styles_manager.dart';

class Heading extends StatelessWidget {
  final String title;

  final Color? color;
  const Heading({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: getSemiBoldStyle(
            color: color ?? ColorManager.blackColor, fontSize: FontSize.s16));
  }
}
