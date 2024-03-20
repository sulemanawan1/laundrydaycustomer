import 'package:flutter/material.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/my_button/my_button.dart';
import 'package:laundryday/widgets/my_heading/heading.dart';

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
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Heading(
                  text: "Total",
                  color: ColorManager.greyColor,
                ),
                Heading(
                  text: "Qty",
                  color: ColorManager. greyColor,
                )
              ]),
          8.ph,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Heading(
              text: "$total SAR",
            ),
            Heading(
              text: "$quantity Items",
            )
          ]),
          8.ph,
          MyButton(
            name: 'Complete Order',
            onPressed: onPressed,
          ),
          15.ph,
        ]),
      ),
    );
  }
}
