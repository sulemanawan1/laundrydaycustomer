import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';

class Heading extends StatelessWidget {
  final String text;

  final  Color? color;
  const Heading({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: color ??ColorManager. blackColor,
          fontSize: 16,
          fontWeight: FontWeight.w500),
    );
  }
}
