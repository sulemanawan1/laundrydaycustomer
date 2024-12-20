import 'package:flutter/material.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class PaymentSummaryText extends StatelessWidget {
  final String text1;
  final String text2;
  final TextStyle? text1style;
  final String? text2PostFix;

  PaymentSummaryText(
      {super.key,
      required this.text1,
      required this.text2,
      this.text1style,
      this.text2PostFix = 'SAR'});

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
              '${text2} ${(text2PostFix == null) ? '' : text2PostFix}',
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
