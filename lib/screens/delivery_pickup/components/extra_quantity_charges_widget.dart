import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';

class ExtraQuantityChargesWidget extends StatelessWidget {
  final String title;
  const ExtraQuantityChargesWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.amber.withOpacity(0.1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 12),
              ),
              2.pw,
              Icon(
                Icons.warning,
                color: ColorManager.greyColor,
                size: 14,
              ),
            ],
          ),
        ));
  }
}
