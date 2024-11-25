import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class MyButton extends StatelessWidget {
  final String? title;
  final bool isBorderButton;
  final void Function()? onPressed;
  final Color? borderColor;
  final Color? color;
  final Color? textColor;
  final bool? isLoading;
  final Widget? widget;
  final EdgeInsetsGeometry? padding;
  MyButton(
      {super.key,
      required this.title,
      this.borderColor,
      this.color,
      this.onPressed,
      this.textColor,
      this.isLoading,
      this.widget,
      this.padding,
      this.isBorderButton = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: isLoading == false ? null : onPressed,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              border: isBorderButton
                  ? Border.all(color: borderColor ?? ColorManager.primaryColor)
                  : null,
              color: isLoading == false
                  ? (isBorderButton ? null : ColorManager.greyColor)
                  : (isBorderButton
                      ? null
                      : color ?? ColorManager.primaryColor),
              borderRadius: BorderRadius.circular(40)),
          child: widget ??
              Center(
                child: Text(
                  title!,
                  style: getSemiBoldStyle(
                    color: isBorderButton
                        ? textColor ?? ColorManager.primaryColor
                        : ColorManager.whiteColor,
                    fontSize: 16,
                  ),
                ).tr(),
              ),
        ),
      ),
    );
  }
}
