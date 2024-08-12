import 'package:flutter/material.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/screens/laundries/model/delivery_pickup_laundry_model.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/screens/laundries/model/laundry_by_area.model.dart'
    as laundrybyareamodel;

class ResuableLaundryTile extends StatelessWidget {
  final laundrybyareamodel.Datum laundry;
  final void Function()? onTap;
  const ResuableLaundryTile({super.key, required this.laundry, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 6,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: ColorManager.greyColor, width: 0.3)),
                          child: Stack(alignment: Alignment.center, children: [
                            Image.asset(
                              fit: BoxFit.contain,
                              "assets/laundry_shop.jpg",
                            ),
                            laundry.branch!.verificationStatus == 'closed'
                                ? Container(
                                    height: 80,
                                    width: 80,
                                    decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        color: Colors.black.withOpacity(0.6)),
                                    child: Center(
                                        child: Text(
                                      'Closed',
                                      style: getSemiBoldStyle(
                                        color: ColorManager.whiteColor,
                                      ),
                                    )),
                                  )
                                : const SizedBox()
                          ]),
                        ),
                      )),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        laundry.name.toString(),
                        style: getSemiBoldStyle(color: ColorManager.blackColor),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          laundry.services!.first.serviceName.toString(),
                          style:
                              getSemiBoldStyle(color: ColorManager.greyColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            4.ph,
            const Divider(
              thickness: 0.4,
            ),
            Row(
              children: [
                10.pw,
                const Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.amber,
                ),
                5.pw,
                Text(
                  laundry.rating.toString(),
                  style: getSemiBoldStyle(
                    color: ColorManager.blackColor,
                  ),
                ),
                15.pw,
                Icon(
                  Icons.place_outlined,
                  size: 16,
                  color: ColorManager.blackColor,
                ),
                5.pw,
                Text(
                  "${laundry.distance.toString()}",
                  style: getSemiBoldStyle(
                    color: ColorManager.greyColor,
                  ),
                ),
              ],
            ),
            10.ph
          ],
        ),
      ),
    );
  }
}

class ResuableDeliveryPickuPLaundryTile extends StatelessWidget {
  final DeliveryPickupLaundryModel laundry;
  final void Function()? onTap;
  const ResuableDeliveryPickuPLaundryTile(
      {super.key, required this.laundry, this.onTap});

  @override
  Widget build(BuildContext context) {
    List<String> parts = laundry.destinationAddresses.toString().split('،');

    String part3 = (parts.length > 1) ? parts[1].trim() : '';
    String part4 = '';
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 6,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: ColorManager.greyColor, width: 0.3)),
                          child: Stack(alignment: Alignment.center, children: [
                            Image.asset(
                              fit: BoxFit.contain,
                              "assets/laundry_shop.jpg",
                            ),
                            // laundry.openingHours == false
                            //     ? Container(
                            //         height: 80,
                            //         width: 80,
                            //         decoration: ShapeDecoration(
                            //             shape: RoundedRectangleBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(8)),
                            //             color: Colors.black.withOpacity(0.6)),
                            //         child: Center(
                            //             child: Text(
                            //           'Closed',
                            //           style: GoogleFonts.poppins(
                            //               color: ColorManager.whiteColor,
                            //               fontWeight: FontWeight.w600),
                            //         )),
                            //       )
                            //     : const SizedBox()
                          ]),
                        ),
                      )),
                  Expanded(
                    child: ListTile(
                      isThreeLine: false,
                      title: Text(
                        laundry.name.toString(),
                        style: getSemiBoldStyle(color: ColorManager.blackColor),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text(
                              textDirection: TextDirection.ltr,
                              maxLines: 2,
                              "${part3}",
                              style: getSemiBoldStyle(
                                  color: ColorManager.greyColor),
                            ),
                            2.pw,
                            Text(
                              textDirection: TextDirection.ltr,
                              maxLines: 2,
                              "${part4}",
                              style: getSemiBoldStyle(
                                  color: ColorManager.purpleColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            4.ph,
            const Divider(
              thickness: 0.4,
            ),
            Row(
              children: [
                10.pw,
                laundry.rating == null
                    ? SizedBox()
                    : Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          5.pw,
                          Text(
                            laundry.rating.toString(),
                            style: getSemiBoldStyle(
                              color: ColorManager.blackColor,
                            ),
                          ),
                        ],
                      ),
                15.pw,
                Icon(
                  Icons.place_outlined,
                  size: 16,
                  color: ColorManager.blackColor,
                ),
                5.pw,
                Text(
                  "${laundry.distance}",
                  style: getRegularStyle(
                    color: ColorManager.greyColor,
                  ),
                ),
                5.pw,
                Text(
                  laundry.openingHours == true ? 'Opened' : '',
                  style: getSemiBoldStyle(
                    color: Colors.green,
                  ),
                ),
                5.pw,
              ],
            ),
            10.ph
          ],
        ),
      ),
    );
  }
}
