import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';

class ReuseableLaundryDetailCard extends StatelessWidget {
  final LaundryModel laundryModel;
  const ReuseableLaundryDetailCard({super.key,required this.laundryModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Card(
        color:ColorManager.whiteColor ,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  laundryModel.name.toString(),
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.amber,
                    ),
                    2.pw,
                    Text(laundryModel.rating.toString()),
                    4.pw,
                    Text(
                      'Reviews',
                      style: GoogleFonts.poppins(color: ColorManager. primaryColor),
                    )
                  ],
                )
              ],
            ),
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                     Icon(
                      Icons.directions_walk,
                      size: 14,
                      color: ColorManager.primaryColor,
                    ),
                    10.pw,
                    Text(
                      "7- 20 min",
                      style: GoogleFonts.poppins(color: ColorManager. greyColor),
                    ),
                  ],
                ),
                Text(
                  '${laundryModel.distance.toString()} km',
                  style: GoogleFonts.poppins(color: ColorManager. greyColor),
                ),
              ],
            ),
            10.ph,
            SizedBox(
              child: Row(
                children: [
                   Icon(
                    Icons.store,
                    color: ColorManager. primaryColor,
                    size: 14,
                  ),
                  10.pw,
                  Expanded(
                    child: Text(
                      laundryModel.address.toString(),
                      style: GoogleFonts.poppins(color: ColorManager. greyColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            10.ph,
          ]),
        ),
      ),
    );
  }
}
