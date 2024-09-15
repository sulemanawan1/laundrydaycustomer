import 'package:flutter/material.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/font_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/config/resources/sized_box.dart';

class AddressDetailCard extends StatelessWidget {
  final String origin;
  final String destination;

  AddressDetailCard({
    required this.origin,
    required this.destination,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.silverWhite,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          8.ph,
          Row(
            children: [
              const Icon(
                Icons.flag,
                size: 14,
              ),
              10.pw,
              Text(
                'Pickup From',
                style: getMediumStyle(color: ColorManager.blackColor),
              )
            ],
          ),
          8.ph,
          Text(
            origin,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: getMediumStyle(
                color: ColorManager.greyColor, fontSize: FontSize.s10),
          ),
          8.ph,
          Row(
            children: [
              const Icon(Icons.inventory, size: 14),
              10.pw,
              Text(
                'Delivered To',
                style: getMediumStyle(color: ColorManager.blackColor),
              )
            ],
          ),
          8.ph,
          Text(
            destination,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: getMediumStyle(
                color: ColorManager.greyColor, fontSize: FontSize.s10),
          ),
          8.ph,
        ]),
      ),
    );
  }
}
