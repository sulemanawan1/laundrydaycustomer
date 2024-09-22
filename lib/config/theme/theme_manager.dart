import 'package:flutter/material.dart';
import 'package:laundryday/services/resources/colors.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

import '../../services/resources/value_manager.dart';

getApplicatonTheme() {
  return ThemeData(
    iconTheme: IconThemeData(color: ColorManager.primaryColor),
    radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(ColorManager.primaryColor)),
    primaryColor: ColorManager.primaryColor,
    cardTheme: CardTheme(
        shadowColor: ColorManager.greyColor,
        color: ColorManager.whiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8))),
    listTileTheme: ListTileThemeData(
        subtitleTextStyle: getRegularStyle(
          fontSize: 15,
          color: ColorManager.greyColor,
        ),
        titleTextStyle: getRegularStyle(
          fontSize: 16,
          color: ColorManager.blackColor,
        )),
    scaffoldBackgroundColor: ColorManager.backgroundColor,
    useMaterial3: false,
  );
}
