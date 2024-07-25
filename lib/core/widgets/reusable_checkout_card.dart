import 'package:flutter/material.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/core/widgets/heading.dart';

class ReusableCheckOutCard extends StatelessWidget {
  final void Function()? onPressed;
  final String total;
  final String quantity;
  const ReusableCheckOutCard(
      {super.key,
      required this.onPressed,
      required this.quantity,
      required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          15.ph,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Heading(
              title: "Total",
              color: ColorManager.greyColor,
            ),
            Heading(
              title: "Qty",
              color: ColorManager.greyColor,
            )
          ]),
          8.ph,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Heading(
              title: "$total SAR",
            ),
            Heading(
              title: "$quantity Items",
            )
          ]),
          8.ph,
          MyButton(
            title: 'Complete Order',
            onPressed: onPressed,
          ),
          15.ph,
        ]),
      ),
    );
  }
}
