import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';

class ResuableLaundryTile extends StatelessWidget {
  final LaundryModel? laundry;
  final void Function()? onTap;
  const ResuableLaundryTile({super.key, this.laundry, this.onTap});

  @override
  Widget build(BuildContext context) {
    var types = laundry!.seviceTypes.map((e) => e.type).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Card(
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
                            child:
                                Stack(alignment: Alignment.center, children: [
                              Image.asset(
                                fit: BoxFit.contain,
                                laundry!.logo.toString(),
                              ),
                              laundry!.status == 'closed'
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
                                        style: GoogleFonts.poppins(
                                            color: ColorManager.whiteColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    )
                                  : const SizedBox()
                            ]),
                          ),
                        )),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          laundry!.name.toString(),
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            types.toString().replaceAll(RegExp(r"[\[\]]"), ""),
                            style: GoogleFonts.poppins(
                                color: ColorManager.greyColor),
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
                    laundry!.rating.toString(),
                    style: GoogleFonts.poppins(
                        color: ColorManager.blackColor,
                        fontWeight: FontWeight.w400),
                  ),
                  15.pw,
                  Icon(
                    Icons.place_outlined,
                    size: 16,
                    color: ColorManager.blackColor,
                  ),
                  5.pw,
                  Text(
                    "${laundry!.distance.toString()} km",
                    style: GoogleFonts.poppins(
                        color: ColorManager.greyColor,
                        fontWeight: FontWeight.w400),
                  ),
                  15.pw,
                  Icon(
                    Icons.schedule_outlined,
                    size: 16,
                    color: ColorManager.blackColor,
                  ),
                  5.pw,
                  Text(
                    "${laundry!.timeslot!.first.openTime.hour} ${laundry!.timeslot!.first.openTime.period.name}-${laundry!.timeslot!.first.closeTime.hourOfPeriod}${laundry!.timeslot!.first.closeTime.period.name}",
                    style: GoogleFonts.poppins(
                        color: ColorManager.greyColor,
                        fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                  5.pw,
                  Text(
                    laundry!.status ?? '',
                    style: GoogleFonts.poppins(
                        color: laundry!.status == 'closed'
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.w500),
                  ),
                  5.pw,
                ],
              ),
              10.ph
            ],
          ),
        ),
      ),
    );
  }
}
