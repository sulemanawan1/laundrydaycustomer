import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/constants/sized_box.dart';

class OrderStatusInfoWidget extends StatelessWidget {
  final String image, title, description;


   const OrderStatusInfoWidget({
    super.key,required this.image,
   required this.title,
   required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Image.asset(
          image,
          height: 180,
        )),
        10.ph,
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        10.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            description,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorManager.greyColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
