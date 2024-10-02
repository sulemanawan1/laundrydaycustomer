import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:shimmer/shimmer.dart';

class ReusabelLaundryDetailBannerCard extends StatelessWidget {
  final String serviceName;
  final String branchName;
  final String rating;
  final String duration;
  final String distance;

  final String address;

  ReusabelLaundryDetailBannerCard({
    required this.serviceName,
    required this.branchName,
    required this.rating,
    required this.duration,
    required this.distance,
    required this.address,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          getBanner(serviceName: serviceName),
          height: 250,
          fit: BoxFit.fitWidth,
          width: double.infinity,
        ),
        Positioned(
          top: 40,
          left: 20,
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: ColorManager.whiteColor),
                child: const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.arrow_back_ios,
                  ),
                )),
          ),
        ),
        Positioned(
          left: 20,
          top: 160,
          right: 20,
          child: Card(
            color: ColorManager.whiteColor,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        branchName,
                        style: getSemiBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber,
                          ),
                          2.pw,
                          Text(rating.toString()),
                          4.pw,
                          Text(
                            'Reviews',
                            style: getRegularStyle(
                                color: ColorManager.primaryColor),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        10.pw,
                        Text(
                          duration,
                          style: getRegularStyle(color: ColorManager.greyColor),
                        ),
                      ],
                    ),
                    Text(
                      '${distance}',
                      style: getRegularStyle(color: ColorManager.greyColor),
                    ),
                  ],
                ),
                10.ph,
                Row(
                  children: [
                    Icon(
                      Icons.store,
                      color: ColorManager.primaryColor,
                      size: 14,
                    ),
                    10.pw,
                    Expanded(
                      child: Text(
                        address,
                        style: getRegularStyle(color: ColorManager.greyColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                10.ph,
              ]),
            ),
          ),
        )
      ],
    );
  }

  String getBanner({required String serviceName}) {
    if (serviceName.toLowerCase() == 'clothes') {
      return "assets/category_banner/clothes_banner.jpg";
    } else if (serviceName.toLowerCase() == 'blankets') {
      return "assets/blanket_and_linen_banner.jpg";
    } else if (serviceName.toLowerCase() == 'carpets') {
      return AssetImages.carpet;
    }
    return '';
  }
}

class ReusabelLaundryDetailBannerCardShimmerEffect extends StatelessWidget {
  const ReusabelLaundryDetailBannerCardShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
            ),
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ColorManager.whiteColor),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 5),
                  )),
            ),
            Positioned(
              left: 20,
              top: 160,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Card(),
                ),
              ),
            )
          ],
        ));
  }
}
