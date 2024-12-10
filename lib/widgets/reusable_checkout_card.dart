import 'package:flutter/material.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/widgets/my_button.dart';

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
            Text(
              'Total',
              style: getSemiBoldStyle(
                color: ColorManager.greyColor,
              ),
            ),
            Text(
              'Qty',
              style: getSemiBoldStyle(
                color: ColorManager.greyColor,
              ),
            )
          ]),
          8.ph,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "$total SAR",
              style: getSemiBoldStyle(
                color: ColorManager.greyColor,
              ),
            ),
            Text(
              "$quantity Items",
              style: getSemiBoldStyle(
                color: ColorManager.greyColor,
              ),
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
