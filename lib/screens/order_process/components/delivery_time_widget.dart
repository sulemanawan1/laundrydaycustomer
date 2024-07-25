import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/core/constants/sized_box.dart';

class DeliveryTimeWidget extends StatelessWidget {
  const DeliveryTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Delivered within',
            style: GoogleFonts.poppins(
              fontSize: 16,
            )),
        5.ph,
        Text(
          '30-40 minutes',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
