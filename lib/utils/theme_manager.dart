import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/value_manager.dart';

getApplicatonTheme() {
  return ThemeData(
    iconTheme: IconThemeData(color: ColorManager.primaryColor),
    radioTheme: RadioThemeData(
        fillColor: MaterialStatePropertyAll(ColorManager.primaryColor)),
    primaryColor: ColorManager.primaryColor,
    cardTheme: CardTheme(
        shadowColor: ColorManager.greyColor,
        color: ColorManager.whiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8))),
    listTileTheme: ListTileThemeData(
      subtitleTextStyle: GoogleFonts.poppins(
            fontSize: 15,
            color: ColorManager.greyColor,
            fontWeight: FontWeight.w400) ,
        titleTextStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: ColorManager.blackColor,
            fontWeight: FontWeight.w400)),
    scaffoldBackgroundColor: ColorManager.backgroundColor,
    useMaterial3: false,
  );
}
