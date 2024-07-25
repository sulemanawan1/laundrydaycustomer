import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';

class CarpetLaundryDetailWidget extends StatelessWidget {
  final LaundryModel laundryModel;
  const CarpetLaundryDetailWidget({super.key,required this.laundryModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          laundryModel.logo.toString(),
          height: 80,
        ),
        10.ph,
        Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      ColorManager.greyColor.withOpacity(0.1), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 6, // Blur radius
                  offset: const Offset(0, 3), // Offset for the shadow
                ),
              ],
              color: ColorManager.mediumWhiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorManager.mediumWhiteColor)),
          height: 110,
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.ph,
                Text(laundryModel!.name.toString(),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 18)),
                5.ph,
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.place,
                      size: 16,
                    ),
                    5.pw,
                    Text(
                      "${laundryModel!.distance.toString()} km",
                      style: GoogleFonts.poppins(
                          color: ColorManager.greyColor,
                          fontWeight: FontWeight.w400),
                    ),
                    10.pw,
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    5.pw,
                    Text(
                      laundryModel.rating.toString(),
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
                10.ph,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
