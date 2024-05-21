import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/order_review/order_review.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/heading.dart';

// ignore: must_be_immutable
class PaymentSummaryWidget extends StatelessWidget {
  ServicesModel? service;
  WidgetRef ref;
  PaymentSummaryWidget({super.key, this.service, required this.ref});

  @override
  Widget build(BuildContext context) {
    final states = ref.watch(orderReviewProvider);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading(
              text: 'Payment Summary',
            ),
            10.ph,
            Divider(),
            const PaymentSummaryText(text1: 'Items cost', text2: '40 SAR'),
            Divider(),
            PaymentSummaryText(
                text1: 'Delievery Fees',
                text2: "${service!.deliveryFee.toString()} SAR"),
            PaymentSummaryText(
                text1: 'Operation Fees',
                text2: "${service!.operationFee.toString()} SAR"),
            // PaymentSummaryText(
            //     text1: 'VAT inclusive', text2: "${service!.vat} SAR"),
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Delivery',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${states.total} SAR',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}

class PaymentSummaryText extends StatelessWidget {
  final String text1;
  final String text2;

  const PaymentSummaryText(
      {super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            Text(
              text2,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        5.ph,
      ],
    );
  }
}
