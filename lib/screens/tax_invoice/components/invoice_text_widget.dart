import 'package:flutter/material.dart';
import 'package:laundryday/constants/sized_box.dart';

class InvoiceTextWidget extends StatelessWidget {
  final String? title;
  final String? text;

  const InvoiceTextWidget({super.key, required this.text, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textAlign: TextAlign.right,
              text!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              textAlign: TextAlign.right,
              title!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        15.ph,
      ],
    );
  }
}
