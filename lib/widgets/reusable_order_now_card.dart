import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';

class ReusableOrderNowCard extends StatelessWidget {
  final void Function()? onPressed;

  const ReusableOrderNowCard({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      color: ColorManager.whiteColor,
      shadowColor: ColorManager.mediumWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.ph,
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p12),
                    child: Text(
                      'Order from the Nearest\nLaundry',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16),
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
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: Text("Laundry,Dry Cleaning and Pressing",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                )),
          ),
          20.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: MyButton(
              name: 'Order Now',
              onPressed: onPressed,
            ),
          ),
          20.ph,
        ],
      ),
    );
  }
}
