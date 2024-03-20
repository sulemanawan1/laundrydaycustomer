import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';

class Utils {
  static showToast(
      {required msg,
      Color? backgroundColor,
      bool isNegative = false,
      ToastGravity? gravity}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: isNegative ? Colors.red : ColorManager.blackColor,
      textColor: ColorManager.whiteColor,
    );
  }

  static showResuableBottomSheet(
      {required BuildContext context,
      required Widget widget,
      required String title,
      Color? backgroundColor}) {
    showModalBottomSheet(
      backgroundColor: backgroundColor ?? backgroundColor,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: GoogleFonts.poppins(
                            color: ColorManager.blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          shape: BoxShape.circle),
                      child: IconButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            color: ColorManager.greyColor,
                          )),
                    )
                  ],
                ),
                widget
              ],
            ),
          ),
        );
      },
    );
  }
}
