import 'package:flutter/material.dart';
import 'package:laundryday/services/resources/colors.dart';
import 'package:laundryday/services/resources/font_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

// ignore: must_be_immutable
class SubHeading extends StatelessWidget {
  final String title;
  final Color? color;
  TextAlign? textAlign;

  SubHeading({super.key, required this.title, this.color, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        textAlign: textAlign,
        style: getMediumStyle(
            color: color ?? ColorManager.greyColor, fontSize: FontSize.s11));
  }
}
