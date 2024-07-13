import 'package:flutter/material.dart';
import 'package:laundryday/utils/constants/colors.dart';
import 'package:laundryday/utils/constants/font_manager.dart';
import 'package:laundryday/utils/constants/value_manager.dart';
import 'styles_manager.dart';

getApplicatonTheme() {
  return ThemeData(
//App theme
    primaryColor: ColorManager.primaryColor,
    primaryColorLight: ColorManager.primaryColorOpacity10,
    // primaryColorDark: ,
    // disabledColor: ,

// Appbar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      titleTextStyle: getBoldStyle(
          color: ColorManager.primaryColor, fontSize: FontSize.s20),
    ),

// iconTheme
    primaryIconTheme: IconThemeData(color: ColorManager.primaryColor),
    iconTheme: IconThemeData(color: ColorManager.primaryColor),

// Radio Button Theme

    radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(ColorManager.primaryColor)),

    //Card Theme

    cardTheme: CardTheme(
        shadowColor: ColorManager.greyColor,
        color: ColorManager.whiteColor,
        elevation: AppSize.s0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8))),

    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(), buttonColor: ColorManager.primaryColor),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primaryColor,
            foregroundColor: ColorManager.whiteColor,
            maximumSize: const Size(double.infinity, 44),
            minimumSize: const Size(double.infinity, 44),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s8)),
            textStyle: getRegularStyle(
                color: ColorManager.whiteColor, fontSize: FontSize.s14))),
    // ListTile Theme
    listTileTheme: ListTileThemeData(
        subtitleTextStyle: getMediumStyle(
            color: ColorManager.greyColor, fontSize: FontSize.s14),
        titleTextStyle: getSemiBoldStyle(
            color: ColorManager.blackColor, fontSize: FontSize.s15)),

    scaffoldBackgroundColor: ColorManager.silverWhite,

    useMaterial3: false,
    popupMenuTheme: PopupMenuThemeData(
        surfaceTintColor: ColorManager.whiteColor,
        labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => getMediumStyle(color: ColorManager.blackColor)),
        textStyle: getMediumStyle(color: ColorManager.blackColor),
        color: ColorManager.mediumWhiteColor),

    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor: WidgetStateColor.resolveWith(
                (states) => ColorManager.primaryColorOpacity10))),
    switchTheme: SwitchThemeData(
        trackOutlineColor:
            WidgetStateColor.resolveWith((states) => ColorManager.lightGrey),
        trackOutlineWidth: WidgetStateProperty.all(1),
        trackColor: WidgetStateColor.resolveWith(
            (states) => ColorManager.primaryColorOpacity10),
        thumbColor: WidgetStateColor.resolveWith(
            (states) => ColorManager.primaryColor)),
    splashColor: ColorManager.primaryColorOpacity10,
    checkboxTheme: CheckboxThemeData(
        side: const BorderSide(width: 0.3),
        checkColor:
            WidgetStateColor.resolveWith((states) => ColorManager.whiteColor),
        fillColor: WidgetStateColor.resolveWith(
            (states) => ColorManager.primaryColor)),

    textTheme: TextTheme(
        titleLarge: getSemiBoldStyle(
            color: ColorManager.blackColor, fontSize: FontSize.s16),
        titleMedium: getRegularStyle(
            color: ColorManager.blackColor, fontSize: FontSize.s14),
        headlineSmall: getMediumStyle(color: Colors.black),
        bodySmall: getRegularStyle(color: Colors.black, fontSize: FontSize.s14),
        bodyMedium:
            getRegularStyle(color: Colors.black, fontSize: FontSize.s16),
        bodyLarge: getRegularStyle(color: Colors.black, fontSize: FontSize.s16),
        titleSmall: getMediumStyle(color: ColorManager.greyColor),
        headlineMedium: getRegularStyle(
            color: ColorManager.primaryColor, fontSize: FontSize.s14),
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.primaryColor, fontSize: FontSize.s24)),
    // inputDecorationTheme: InputDecorationTheme(

    //     errorStyle: getRegularStyle(color: ColorManager.redColor,fontSize: FontSize.s10),
    //   labelStyle: getMediumStyle(color: ColorManager.blackColor),
    //   fillColor: ColorManager.whiteColor,
    //   filled: true,
    //   hintStyle: getRegularStyle(color: ColorManager.greyColor),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(AppSize.s8),
    //     borderSide: BorderSide(color: ColorManager.primaryColor, width: 1.5),
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(AppSize.s8),
    //     borderSide:
    //         BorderSide(color: ColorManager.lightGrey, width: 1.5),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(AppSize.s8),
    //     borderSide: BorderSide(color: ColorManager.redColor, width: 1.5),
    //   ),
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(AppSize.s8),
    //     borderSide: BorderSide(color: ColorManager.primaryColor, width: 1.0),
    //   ),
    // ),
  );
}
