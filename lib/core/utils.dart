import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/services/flutter_phone_direct_caller.dart';

class Utils {
  Utils._();
  
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

  static void showReusableDialog({
    required BuildContext context,
    required String title,
    required String description,
    required List<Widget> buttons,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: getSemiBoldStyle(
                  color: ColorManager.blackColor, fontSize: FontSize.s14),
            ),
            content: Text(
              description,
              style: getMediumStyle(
                  color: ColorManager.blackColor, fontSize: FontSize.s12),
            ),
            actions: buttons,
          );
        });
  }

  static showResuableBottomSheet(
      {required BuildContext context,
      required Widget widget,
      required String title,
      Color? backgroundColor}) {
    showModalBottomSheet(
      useSafeArea: true,
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
                        style: getSemiBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: 18,
                        )),
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

  static showSnackBar(
      {required BuildContext context,
      required String message,
      Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      showCloseIcon: true,
      backgroundColor: color,
      content: Text(message),
    ));
  }

  static Future<dynamic> resuableCameraGalleryBottomSheet(
      {required BuildContext context,
      required void Function()? onCamerButtonPressed,
      required void Function()? onGalleryButtonPressed}) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          topRight: Radius.circular(AppSize.s12),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              10.ph,
              const Text(
                'Choose Photo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              10.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primaryColor,
                    ),
                    icon: const Icon(Icons.camera),
                    onPressed: onCamerButtonPressed,
                    label: const Text('Camera'),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primaryColor,
                    ),
                    icon: const Icon(Icons.image),
                    onPressed: onGalleryButtonPressed,
                    label: const Text('Gallery'),
                  ),
                ],
              ),
              10.ph,
            ],
          ),
        );
      },
    );
  }

  static metertoKilometer(int meter) {
    return meter / 1000;
  }

  static directCallBottomSheeet(
      {required BuildContext context, required String mobileNumber}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      builder: (BuildContext context) {
        const ShapeBorder shapeBorder = RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        );

        const TextAlign textAlign = TextAlign.center;
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            children: [
              ListTile(
                onTap: () {
                  callNumber(mobileNumber: mobileNumber);
                  context.pop();
                },
                shape: shapeBorder,
                tileColor: ColorManager.whiteColor,
                title: Text(
                  mobileNumber.toString(),
                  textAlign: textAlign,
                ),
                trailing: const Icon(Icons.call),
              ),
              10.ph,
              ListTile(
                shape: shapeBorder,
                onTap: () {
                  context.pop();
                },
                tileColor: ColorManager.whiteColor,
                title: const Text(
                  'Cancel',
                  textAlign: textAlign,
                ),
              ),
              10.ph,
            ],
          ),
        );
      },
    );
  }
}
