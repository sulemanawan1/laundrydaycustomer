import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/screens/blankets_and_linen/blanket_and_linen_service_detail.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/value_manager.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: AppMargin.m10),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: groupedItems.length,
              itemBuilder: (BuildContext context, int index) {
                String category = groupedItems.keys.elementAt(index);
                List itemsInCategory = groupedItems[category]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    category == 'deliverypickup'
                        ? Center(
                            child: Container(
                              decoration: ShapeDecoration(
                                shape: const StadiumBorder(),
                                color: ColorManager.lightPurple,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p10),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Heading(
                                    text: 'Recieving from the Laundry',
                                    color: ColorManager.purpleColor,
                                  ),
                                )),
                              ),
                            ),
                          )
                        : const SizedBox(),
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
                                        name: 'Find another Laundry',
                                        onPressed: () {
                                          context.pop();
                                        },
                                      ),
                                      30.ph,
                                    ],
                                  ),
                                  title: 'Closed');
                            } else {
                              if (itemsInCategory[index].type ==
                                  'deliverypickup') {
                                GoRouter.of(context)
                                    .pushNamed(RouteNames().deliveryPickup,
                                        extra: Arguments(
                                          laundryModel: itemsInCategory[index],
                                        ));
                              } else {
                                GoRouter.of(context).pushNamed(
                                    RouteNames().blanketsCategory,
                                    extra: itemsInCategory[index]);
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
