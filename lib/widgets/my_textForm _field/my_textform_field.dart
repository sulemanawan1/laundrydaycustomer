import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';

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
  final String? labelText;
  final int? maxLines;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color? fillColor;
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
      this.padding,
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
      width: width ?? double.infinity,
      child: TextFormField(
        onChanged: onChange,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500, fontSize: 15, color: textColor),
        keyboardType: textInputType,
        textAlign: textAlign ?? TextAlign.start,
        onTap: onTap,
        autofillHints: autofillHints,
        validator: validator,
        maxLines: maxLines ?? 1,
        controller: controller,
        maxLength: maxLength,
        cursorColor: ColorManager.primaryColor,
        readOnly: readOnly ?? false,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          counterStyle: GoogleFonts.poppins(color: ColorManager.whiteColor),
          errorStyle: GoogleFonts.poppins(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 10,
          ),
          
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding:
              contentPadding ?? const EdgeInsets.fromLTRB(25, 13, 0, 13),
          filled: fill ?? true,
          labelStyle: GoogleFonts.poppins(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: labelTextColor ?? const Color(0xff555555)),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: hintTextColor ?? const Color(0xff555555),
          ),
          hintText: hintText,
          labelText: labelText,
          fillColor: fillColor ?? ColorManager.whiteColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: ColorManager.primaryColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xffEEEEEE), width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: ColorManager.primaryColor, width: 1.0),
          ),
        ),
      ),
    );
  }
}
