import 'package:flutter/widgets.dart';
import 'package:laundryday/constants/assets_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';

class LaundryDetailButton extends StatelessWidget {
  final String branchName;
  final int totalItems;

  void Function()? onTap;
  LaundryDetailButton(
      {super.key, required this.branchName, required this.totalItems,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: AppPadding.p21),
          child: Column(
            children: [
              12.ph,
              Row(
                children: [
                  Image.asset(
                    AssetImages.laundryIcon,
                    width: 32,
                  ),
                  10.pw,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 142,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          branchName.toString(),
                          style: getRegularStyle(
                              fontSize: FontSize.s20, color: Color(0xFF525253)),
                        ),
                      ),
                      if (totalItems != 0) ...[
                        Text(
                          '${totalItems}x items',
                          style: getRegularStyle(
                              fontSize: FontSize.s12, color: Color(0xFF525253)),
                        )
                      ]
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Details',
                        style: getRegularStyle(
                            color: ColorManager.nprimaryColor,
                            fontSize: FontSize.s12),
                      ),
                      10.pw,
                      Image.asset(
                        AssetImages.forward,
                        width: 11.11,
                      )
                    ],
                  ),
                  25.pw
                ],
              ),
              10.ph
            ],
          ),
        ),
        width: MediaQuery.sizeOf(context).width * 0.85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            color: Color(0xFFF7F7F7)),
      ),
    );
  }
}
