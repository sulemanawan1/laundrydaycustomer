import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/screens/services/model/services_model.dart' as s;

class PaymentSummaryWidget extends ConsumerWidget {
  final s.Datum? service;

  PaymentSummaryWidget({
    super.key,
    this.service,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading(
              title: 'Payment Summary',
            ),
            10.ph,
            PaymentSummaryText(
                text1: 'Delievery Fees', text2: "${service!.deliveryFee} SAR"),
            PaymentSummaryText(
                text1: 'Operation Fees',
                text2: "${service!.operationFee.toString()} SAR"),
          ],
        ),
      ),
    );
  }
}

class PaymentSummaryText extends StatelessWidget {
  final String text1;
  final String text2;
  TextStyle? text1style;

  PaymentSummaryText(
      {super.key, required this.text1, required this.text2, this.text1style});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text1,
                style: text1style ??
                    getRegularStyle(fontSize: 14, color: Color(0xFF818181))),
            Text(
              '${text2} SAR ',
              style: getMediumStyle(
                color: Color(0xFF242424),
                fontSize: 14,
              ),
            ),
          ],
        ),
        5.ph,
        Divider(
          color: Color(0xFF818181),
        ),
      ],
    );
  }
}
