import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  void Function()? onPressed;
  List<Widget>? actions;

  bool isLeading;
  MyAppBar(
      {super.key, required this.title, this.isLeading = true, this.onPressed,this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: isLeading,
        iconTheme:  IconThemeData(color: ColorManager. primaryColor),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(241, 240, 245, 1),
        centerTitle: true,
        title: Text(
          title!,
          style: GoogleFonts.poppins(
              color: ColorManager. blackColor, fontSize: 16, fontWeight: FontWeight.w600),
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
            : null);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
