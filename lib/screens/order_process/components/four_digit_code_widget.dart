import 'package:flutter/material.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class FourDigitCodeWidget extends StatelessWidget {
  const FourDigitCodeWidget({
    super.key,
    required this.fourDigitcode,
  });

  final String fourDigitcode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        5.ph,
        Container(
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.amber.shade600,
                  size: 30,
                ),
                10.pw,
                Text(
                  'Share the four-digit code with the courier\n to finalize the order.',
                  style: getRegularStyle(color: ColorManager.blackColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        10.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var code in fourDigitcode.split('')) ...[
              10.pw,
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.primaryColor),
                    shape: BoxShape.circle,
                    color: ColorManager.primaryColor.withOpacity(0.3)),
                child: Center(
                    child: Text(
                  code,
                  style: getBoldStyle(
                      color: ColorManager.blackColor,
                      ),
                )),
              ),
            ]
          ],
        ),
      ],
    );
  }
}
