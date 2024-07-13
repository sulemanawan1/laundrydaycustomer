import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/laundries/view/laundries.dart';
import 'package:laundryday/utils/constants/colors.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/constants/value_manager.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/my_loader.dart';

class CarpetLaundryTile extends ConsumerWidget {
  ServicesModel? services;
  void Function()? onTap;
  CarpetLaundryTile({super.key, this.services, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(laundriesProvider(services!.id)).when(data: (laundries) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: ListView.builder(
          itemCount: laundries.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final laundry = laundries[index];
            return GestureDetector(
              onTap: () {
                GoRouter.of(context)
                    .pushNamed(RouteNames().blanketsCategory, extra: laundry);
              },
              child: Card(
                color: ColorManager.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 2.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager.greyColor,
                                      width: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorManager.mediumWhiteColor),
                              child: Center(
                                child: Image.asset(
                                  laundry.logo.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, left: 20),
                              child: Text(
                                laundry!.name.toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    4.ph,
                    Divider(
                      thickness: 0.2,
                      color: ColorManager.blackColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          5.pw,
                          Text(
                            laundry!.rating.toString(),
                            style: GoogleFonts.poppins(),
                          ),
                          10.pw,
                          Icon(
                            Icons.place,
                            size: 16,
                            color: ColorManager.primaryColor,
                          ),
                          5.pw,
                          Text(
                            "${laundry!.distance.toString()} km",
                            style: GoogleFonts.poppins(
                                color: ColorManager.greyColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    4.ph
                  ],
                ),
              ),
            );
          },
        ),
      );
    }, error: (error, stackTrace) {
      return const Loader();
    }, loading: () {
      return const Loader();
    });
  }
}
