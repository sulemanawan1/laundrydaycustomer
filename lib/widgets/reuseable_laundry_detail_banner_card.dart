import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';

class ReusabelLaundryDetailBannerCard extends StatelessWidget {
  final LaundryModel laundryModel;
  const ReusabelLaundryDetailBannerCard({super.key, required this.laundryModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          laundryModel.banner.toString(),
          height: 250,
          fit: BoxFit.fitWidth,
          width: double.infinity,
        ),
        Positioned(
          top: 40,
          left: 20,
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
                width: 40,
                height: 40,
                decoration:  BoxDecoration(
                    shape: BoxShape.circle, color: ColorManager. whiteColor),
                child: const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.arrow_back_ios,
                  ),
                )),
          ),
        ),
        
        
        Positioned(
          left: 20,
          top: 160,
          right: 20,
          child: Card(
            color: ColorManager. whiteColor,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        laundryModel.name.toString(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      child: Row(
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
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                         // ignore: deprecated_member_use
                         SvgPicture.asset('assets/delivery_agent.svg',height: 18,color: ColorManager. primaryColor,),
                        10.pw,
                        Text(
                          "7- 20 min",
                          style: GoogleFonts.poppins(color: ColorManager. greyColor),
                        ),
                      ],
                    ),
                    Text(
                      '${laundryModel.distance} km',
                      style: GoogleFonts.poppins(color: ColorManager. greyColor),
                    ),
                  ],
                ),
                10.ph,
                Row(
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
                10.ph,
              ]),
            ),
          ),
        )
      ],
    );
  }
}
