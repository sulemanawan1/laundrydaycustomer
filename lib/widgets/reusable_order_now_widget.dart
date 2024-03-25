import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/font_manager.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';

class ReusableOrderNowCard extends StatelessWidget {
  final void Function()? onPressed;

  const ReusableOrderNowCard({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      
      color: ColorManager.lightPurple,
      shadowColor: ColorManager.mediumWhiteColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order from the Nearest',
                          style: GoogleFonts.poppins(
                              color: ColorManager.purpleColor,
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s18),
                        ),
                        Text(
                          'Laundry',
                          style: GoogleFonts.poppins(
                              color: ColorManager.greyColor,
                              fontWeight: FontWeightManager.medium,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    height: 80,
                    'assets/order_now.png',
                  ),
                )
              ],
            ),
          ),
          10.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: onPressed,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s40),
                        color: ColorManager.primaryColor),
                    child: Center(
                      child: Text(
                        'Order Now',
                        style: GoogleFonts.poppins(
                          color: ColorManager.whiteColor,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/delivery_agent_vector.png',
                      height: 40,
                    ),
                    Text(
                      textAlign: TextAlign.start,
                      'Remaining\nVisits',
                      style: GoogleFonts.poppins(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.semiBold),
                    ),
                    10.pw,
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s8),
                          color: ColorManager.mediumWhiteColor,
                        ),
                        child: Center(
                            child: Text(
                          '4',
                          style: GoogleFonts.poppins(
                              color: ColorManager.purpleColor,
                              fontSize: FontSize.s20,
                              fontWeight: FontWeightManager.heavyBold),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.ph
        ],
      ),
    );
  }
}
