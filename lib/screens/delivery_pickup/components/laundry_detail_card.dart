import 'package:flutter/material.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/models/google_laundry_model.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';

class LaundryDetailCard extends StatelessWidget {
  final GoogleLaundryModel laundry;
  LaundryDetailCard({super.key, required this.laundry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: ColorManager.silverWhite,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            8.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    laundry.name.toString(),
                    style: getMediumStyle(color: ColorManager.blackColor),
                  ),
                ),
                laundry.rating == null
                    ? SizedBox()
                    : Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber,
                          ),
                          2.pw,
                          Text(
                            laundry.rating.toString(),
                            style:
                                getRegularStyle(color: ColorManager.blackColor),
                          ),
                          4.pw,
                          Text(
                            'Reviews',
                            style: getMediumStyle(
                                color: ColorManager.primaryColor),
                          )
                        ],
                      )
              ],
            ),
            8.ph,
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: ColorManager.primaryColor,
                ),
                10.pw,
                Text(
                  "${laundry.distanceInKm.toStringAsFixed(1)} Km",
                  style: getMediumStyle(color: ColorManager.greyColor),
                ),
              ],
            ),
            8.ph,
          ]),
        ),
      ),
    );
  }
}
