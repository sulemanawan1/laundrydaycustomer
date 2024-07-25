import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/laundry_items/model/laundry_model.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:shimmer/shimmer.dart';

class ReusabelLaundryDetailBannerCard extends StatelessWidget {
  final NearestLaundryModel nearestLaundryModel;
  ReusabelLaundryDetailBannerCard({
    required this.nearestLaundryModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          getBanner(
              serviceName: nearestLaundryModel.data!.services!.first.serviceName
                  .toString()),
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
                        nearestLaundryModel.data?.name ?? "",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
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
                          Text(nearestLaundryModel.data?.rating.toString() ??
                              ""),
                          4.pw,
                          Text(
                            'Reviews',
                            style: GoogleFonts.poppins(
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
                        SvgPicture.asset(
                          'assets/delivery_agent.svg',
                          height: 18,
                          color: ColorManager.primaryColor,
                        ),
                        10.pw,
                        Text(
                          nearestLaundryModel.data?.duration ?? "",
                          style: GoogleFonts.poppins(
                              color: ColorManager.greyColor),
                        ),
                      ],
                    ),
                    Text(
                      '${nearestLaundryModel.data?.distance ?? ""}',
                      style: GoogleFonts.poppins(color: ColorManager.greyColor),
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
                        nearestLaundryModel.data?.branch?.googleMapAddress ??
                            "",
                        style:
                            GoogleFonts.poppins(color: ColorManager.greyColor),
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
