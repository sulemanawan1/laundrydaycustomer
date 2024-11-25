import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  void Function()? onPressed;
  List<Widget>? actions;
  Color? backgroundColor;

  Color? iconColor;
  bool isLeading;
  MyAppBar(
      {super.key,
      required this.title,
      this.iconColor,
      this.backgroundColor,
      this.isLeading = true,
      this.onPressed,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        automaticallyImplyLeading: isLeading,
        iconTheme: IconThemeData(color: iconColor ?? ColorManager.primaryColor),
        elevation: 0,
        backgroundColor: backgroundColor ?? ColorManager.backgroundColor,
        centerTitle: true,
        title: Text(
          title ?? "",
          style: getSemiBoldStyle(
            color: ColorManager.blackColor,
            fontSize: 16,
          ),
        ),
        actions: actions,
        leading: isLeading
            ? IconButton(
                onPressed: onPressed ??
                    () {
                      context.pop();
                    },
                icon: const Icon(Icons.arrow_back_ios),
              )
            : const SizedBox());
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
