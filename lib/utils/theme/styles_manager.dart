import 'package:flutter/material.dart';
import 'package:laundryday/utils/constants/font_manager.dart';

TextStyle _getTextStyle(
    String fontFamily, double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color);
}

// Regular TextStyle

TextStyle getRegularStyle(
    {double fontSize = FontSize.s10, required Color color}) {
  return _getTextStyle(
      FontConstant.fontFamily, fontSize, FontWeightManager.regular, color);
}

// Medium TextStyle

TextStyle getMediumStyle(
    {double fontSize = FontSize.s10, required Color color}) {
  return _getTextStyle(
      FontConstant.fontFamily, fontSize, FontWeightManager.medium, color);
}

//  Semi Bold TextStyle
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      FontConstant.fontFamily, fontSize, FontWeightManager.semiBold, color);
}

//  Bold TextStyle

TextStyle getBoldStyle({double fontSize = FontSize.s10, required Color color}) {
  return _getTextStyle(
      FontConstant.fontFamily, fontSize, FontWeightManager.bold, color);
}

//  Light TextStyle

TextStyle getlightStyle(
    {double fontSize = FontSize.s10, required Color color}) {
  return _getTextStyle(
      FontConstant.fontFamily, fontSize, FontWeightManager.light, color);
}

TextStyle getHeavyBoldStyle(
    {double fontSize = FontSize.s10, required Color color}) {
  return _getTextStyle(
      FontConstant.fontFamily, fontSize, FontWeightManager.heavyBold, color);
}
