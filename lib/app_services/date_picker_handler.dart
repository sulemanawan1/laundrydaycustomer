import 'package:flutter/material.dart';
import 'package:laundryday/utils/colors.dart';

class DatePickerHandler {
  static Future<DateTime?> datePicker(context) async {
    DateTime? picked = await showDatePicker(
        initialDate: DateTime.now(),
        builder: (context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor:
                    ColorManager. primaryColor, // Change the primary color
                colorScheme:  ColorScheme.light(
                    primary: ColorManager
                        .primaryColor), // Change other colors if needed
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        },
        firstDate: DateTime(1950),
        lastDate: DateTime(2050),
        context: context);
    if (picked != null) {
      return picked;
    } else {
      return null;
    }
  }
}
