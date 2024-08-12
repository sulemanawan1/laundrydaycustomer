import 'package:flutter/material.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';

class AttentionWidget extends StatelessWidget {
  const AttentionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.amber.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Attention: No leather or wool items are allowed.",
                style: getSemiBoldStyle(
                    color: ColorManager.blackColor, fontSize: 10),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Our prices are the same as the current laundry prices.",
                      style: getSemiBoldStyle(
                          color: ColorManager.blackColor, fontSize: 10),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Utils.showResuableBottomSheet(
                          context: context,
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.ph,
                              Text(
                                'No leather or wool items are allowed.',
                                style: getSemiBoldStyle(
                                    fontSize: 18,color: ColorManager.blackColor),
                              ),
                              5.ph,
                              Text(
                                'Our prices are the same as the current laundry prices.All item are completely identical to the prices in the store wihout adding any increase by Laundry Day.',
                                style:getSemiBoldStyle(
                                    fontSize: 16,
                                    
                                    color: ColorManager.greyColor),
                              ),
                              30.ph,
                            ],
                          ),
                          title: 'Attention');
                    },
                    child: Icon(
                      Icons.info,
                      color: Colors.amber.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
