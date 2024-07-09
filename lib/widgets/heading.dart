import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/constants/font_manager.dart';

class Heading extends StatelessWidget {
  final String title;

  final Color? color;
  const Heading({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          color: color ?? ColorManager.blackColor,
          fontSize: 16,
          fontWeight: FontWeightManager.semiBold),
    );
  }
}
