import 'package:flutter/material.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/value_manager.dart';

class DelieveryPickupHeading extends StatelessWidget {
  const DelieveryPickupHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: Center(
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
                    padding: const EdgeInsets.all(AppSize.s8),
                    child: Text(
                      'Recieving from the Laundry',
                      style: getSemiBoldStyle(
                          color: ColorManager.whiteColor,
                          fontSize: FontSize.s15),
                    ))),
          ),
        ),
      ),
    );
  }
}
