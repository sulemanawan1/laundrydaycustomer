import 'package:flutter/widgets.dart';
import 'package:laundryday/constants/assets_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class FourDigitCode extends StatelessWidget {
  final String code;

  FourDigitCode({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    List<String>? fourDigitCode;

    fourDigitCode = code.toString().split('');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            width: 315,
            decoration: BoxDecoration(
                color: Color(0xFFEEEEFE),
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              children: [
                13.ph,
                Row(
                  children: [
                    18.pw,
                    Image.asset(
                      AssetImages.fourDigitCode,
                      height: 16,
                    ),
                    10.pw,
                    Text(
                        textAlign: TextAlign.center,
                        'Share the four-digit code with the courier\n to finalize the order',
                        style: getRegularStyle(
                            fontSize: 10, color: Color(0xFF494B4F)))
                  ],
                ),
                13.ph,
              ],
            ),
          ),
        ),
        15.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: fourDigitCode.map((char) {
            return Container(
              width: AppSize.s46,
              height: AppSize.s46,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromRGBO(158, 158, 158, 1)
                          .withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2)),
                ],
                border: Border.all(width: 1, color: Color(0xFFE3E5E5)),
                color: ColorManager.whiteColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(char,
                    style: getSemiBoldStyle(
                        fontSize: 16, color: ColorManager.nprimaryColor)),
              ),
            );
          }).toList(),
        ),
        20.ph,
      ],
    );
  }
}
