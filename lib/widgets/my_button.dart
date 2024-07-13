import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/constants/colors.dart';

class MyButton extends StatelessWidget {
  final String? title;
  final bool isBorderButton;
  final void Function()? onPressed;
  final Color? borderColor;
  Color? color;
  final Color? textColor;
  bool? isLoading;
  Widget? widget;
  EdgeInsetsGeometry? padding;
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
                  style: GoogleFonts.poppins(
                    color: isBorderButton
                        ? textColor ?? ColorManager.primaryColor
                        : ColorManager.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
