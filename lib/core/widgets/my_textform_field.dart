import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/font_manager.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;
  final int? maxLength;
  final EdgeInsetsGeometry? padding;
  final bool? fill;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final double? fontSize;
  FocusNode? focusNode;
  final String? labelText;
  final int? maxLines;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color? fillColor;
  final Color? counterTextColor;

  final Iterable<String>? autofillHints;
  final TextInputType? textInputType;
  List<TextInputFormatter>? inputFormatters;
  void Function(String)? onChange;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  MyTextFormField(
      {super.key,
      this.maxLines,
      this.textAlign,
      this.onChange,
      this.counterTextColor,
      this.padding,
      this.focusNode,
      this.readOnly,
      this.textColor,
      this.textInputType,
      this.contentPadding,
      this.prefixIcon,
      this.suffixIcon,
      this.inputFormatters,
      this.fontWeight,
      this.fill,
      this.fontSize,
      this.onTap,
      this.width,
      this.height,
      this.maxLength,
      this.controller,
      this.fillColor,
      this.validator,
      required this.hintText,
      this.labelTextColor,
      required this.labelText,
      this.hintTextColor,
      this.autofillHints});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height ?? 40,
      width: width ?? double.infinity,
      child: TextFormField(
        focusNode: focusNode,
        onChanged: onChange,
        keyboardType: textInputType,
        textAlign: textAlign ?? TextAlign.start,
        onTap: onTap,
        autofillHints: autofillHints,
        validator: validator,
        maxLines: maxLines ?? 1,
        controller: controller,
        maxLength: maxLength ?? null,
        cursorColor: ColorManager.primaryColor,
        readOnly: readOnly ?? false,
        inputFormatters: inputFormatters,
        style: getMediumStyle(
            color: textColor ?? ColorManager.blackColor,
            fontSize: FontSize.s11),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 14, left: 14),
          counterStyle: getMediumStyle(
            color: counterTextColor ?? ColorManager.whiteColor,
            fontSize: FontSize.s10,
          ),
          errorStyle: getMediumStyle(
              color: ColorManager.redColor, fontSize: FontSize.s8),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: fill ?? true,
          labelStyle: getMediumStyle(
              color: labelTextColor ?? ColorManager.blackColor,
              fontSize: FontSize.s11),
          hintStyle: getMediumStyle(
              color: hintTextColor ?? ColorManager.greyColor,
              fontSize: FontSize.s11),
          hintText: hintText,
          labelText: labelText,
          fillColor: fillColor ?? ColorManager.silverWhite,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide(
                color: ColorManager.primaryColor, width: AppSize.s1_5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide:
                BorderSide(color: ColorManager.whiteColor, width: AppSize.s1_5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide:
                BorderSide(color: ColorManager.redColor, width: AppSize.s1_5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide(
                color: ColorManager.primaryColor, width: AppSize.s1_5),
          ),
        ),
      ),
    );
  }
}
