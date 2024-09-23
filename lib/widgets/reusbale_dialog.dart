import 'package:flutter/material.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class ReusableDialog extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> buttons;

  ReusableDialog({
    required this.title,
    required this.description,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: getSemiBoldStyle(
            color: ColorManager.blackColor, fontSize: FontSize.s14),
      ),
      content: Text(
        description,
        style: getMediumStyle(
            color: ColorManager.blackColor, fontSize: FontSize.s12),
      ),
      actions: buttons,
    );
  }
}
