import 'package:flutter/material.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/font_manager.dart';
import 'package:laundryday/core/theme/styles_manager.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/core/constants/sized_box.dart';

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
    return Column(
      children: [
        10.ph,
        Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              10.ph,
              Row(
                children: [
                  const Icon(
                    Icons.flag,
                    size: 14,
                  ),
                  10.pw,
                  HeadingMedium(title: 'Pickup From'),
                ],
              ),
              10.ph,
              Text(
                origin,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getMediumStyle(
                    color: ColorManager.greyColor, fontSize: FontSize.s12),
              ),
              10.ph,
              Row(
                children: [
                  const Icon(Icons.inventory, size: 14),
                  10.pw,
                  HeadingMedium(title: 'Delivered To'),
                ],
              ),
              10.ph,
              Text(
                destination,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getMediumStyle(
                    color: ColorManager.greyColor, fontSize: FontSize.s12),
              ),
              10.ph,
            ]),
          ),
        ),
      ],
    );
  }
}
