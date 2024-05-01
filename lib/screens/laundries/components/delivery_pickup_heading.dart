import 'package:flutter/material.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/heading.dart';

class DelieveryPickupHeading extends StatelessWidget {
  const DelieveryPickupHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s8)),
          color: ColorManager.purpleColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p10,
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(AppPadding.p4),
            child: Heading(
              text: 'Recieving from the Laundry',
              color: ColorManager.whiteColor,
            ),
          )),
        ),
      ),
    );
  }
}
