import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/screens/laundries/components/delivery_pickup_heading.dart';
import 'package:laundryday/screens/laundries/model/services_timings_model.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/laundries/view/laundries.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/constants/font_manager.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/constants/value_manager.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/widgets/reuseable_laundry_tile.dart';
import '../../../utils/utils.dart';

class LaundryTile extends ConsumerWidget {
  int serviceId;
  LaundryTile({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(laundriesProvider(serviceId)).when(data: (laundries) {
      var groupedItems = groupItemsByCategory(laundries);

      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: groupedItems.length,
              itemBuilder: (BuildContext context, int index) {
                String category = groupedItems.keys.elementAt(index);

                List itemsInCategory = groupedItems[category]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.ph,
                    category == 'deliverypickup'
                        ? DelieveryPickupHeading()
                        : const SizedBox(),
                    10.ph,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemsInCategory.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ResuableLaundryTile(
                          onTap: () {
                            if (itemsInCategory[index].status == 'closed') {
                              Utils.showResuableBottomSheet(
                                  context: context,
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.ph,
                                      Text(
                                        '${itemsInCategory[index].name} is currently closed.',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      5.ph,
                                      Text(
                                        'Oops! It look like ${itemsInCategory[index].name} is taking a break right now. Please choose another laundry.',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.greyColor),
                                      ),
                                      10.ph,
                                      MyButton(
                                        title: 'Find another Laundry',
                                        onPressed: () {
                                          context.pop();
                                        },
                                      ),
                                      30.ph,
                                    ],
                                  ),
                                  title: 'Closed');
                            } else {
                              // Delivery Pickup Laundries
                              if (itemsInCategory[index].type ==
                                  'deliverypickup') {
                                GoRouter.of(context)
                                    .pushNamed(RouteNames().deliveryPickup,
                                        extra: Arguments(
                                          laundryModel: itemsInCategory[index],
                                        ));
                              } else {
                                // Normal Laundries

                                if (itemsInCategory[index].service.name ==
                                    'Clothes') {
                                  showDialog<void>(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.all(10),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          title: Center(
                                            child: Heading(
                                              title: 'Select Service Type',
                                            ),
                                          ),
                                          content: Consumer(
                                              builder: (context, reff, child) {
                                            List<ServicesTimingModel> li = ref
                                                .watch(laundriessProvider)
                                                .serviceTypesList;

                                            int? selected = ref
                                                .watch(laundriessProvider)
                                                .index;

                                            log(li.length.toString());
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: List.generate(
                                                  li.length,
                                                  (indexx) => GestureDetector(
                                                        onTap: () {
                                                          log(indexx
                                                              .toString());
                                                          ref
                                                              .read(
                                                                  laundriessProvider
                                                                      .notifier)
                                                              .selectServiceTime(
                                                                  index:
                                                                      indexx);

                                                          GoRouter.of(context).pushNamed(
                                                              RouteNames()
                                                                  .blanketsCategory,
                                                              extra:
                                                                  itemsInCategory[
                                                                      index]);
                                                          context.pop();
                                                        },
                                                        child: Column(
                                                          children: [
                                                            20.ph,
                                                            SizedBox(
                                                              width: 200,
                                                              child: Card(
                                                                color: selected ==
                                                                        indexx
                                                                    ? ColorManager
                                                                        .purpleColorOpacity10
                                                                    : ColorManager
                                                                        .mediumWhiteColor,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Center(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        10.ph,
                                                                        Image.asset(
                                                                            color:
                                                                                ColorManager.purpleColor,
                                                                            height: 60,
                                                                            li[indexx].img),
                                                                        10.ph,
                                                                        Text(
                                                                          li[indexx]
                                                                              .name,
                                                                          style: GoogleFonts.poppins(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: FontSize.s16),
                                                                        ),
                                                                        10.ph,
                                                                        Text(
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          li[indexx]
                                                                              .description,
                                                                          style: GoogleFonts.poppins(
                                                                              color: ColorManager.greyColor,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: FontSize.s12),
                                                                        ),
                                                                        10.ph,
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                            );
                                          }));
                                    },
                                  );
                                } else {
                                  GoRouter.of(context).pushNamed(
                                      RouteNames().blanketsCategory,
                                      extra: itemsInCategory[index]);
                                }
                              }
                            }
                          },
                          laundry: itemsInCategory[index],
                        );
                      },
                    ),
                  ],
                );
              }),
        ),
      );
    }, error: (error, stackTrace) {
      return const Loader();
    }, loading: () {
      return const Loader();
    });
  }

  groupItemsByCategory(List<LaundryModel> items) {
    return groupBy(items, (item) => item.type);
  }
}
