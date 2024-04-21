import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';

class HeadingSmall extends StatelessWidget {
  final String title;

  final Color? color;
  const HeadingSmall({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: color ?? ColorManager.blackColor,
      ),
    );
  }
}
