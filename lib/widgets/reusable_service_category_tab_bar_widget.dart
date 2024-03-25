// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/sized_box.dart';

final indexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

class ReusableServiceCategoryTabBar extends ConsumerWidget {
   List<ServiceTypesModel>? list;
  TabController? tabController;
  void Function(int)? onTap;
  ReusableServiceCategoryTabBar(
      {super.key, required this.list, required this.tabController, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      final index = ref.watch(indexProvider);

      return Container(
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: TabBar(
            onTap: onTap,
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                return states.contains(MaterialState.focused)
                    ? null
                    : Colors.transparent;
              },
            ),
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
            labelPadding: EdgeInsets.zero,
            automaticIndicatorColorAdjustment: false,
            unselectedLabelColor: ColorManager.greyColor,
            labelColor: ColorManager.primaryColor,
            controller: tabController,
            labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
            indicatorColor: ColorManager.whiteColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                color: ColorManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  30,
                )),
            tabs: List.generate(list!.length, (indexx) {
              var category = list![indexx];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: index == indexx ? null : Colors.white,
                        border: index == indexx
                            ? Border.all(color: ColorManager.primaryColor)
                            : Border.all(
                                color: ColorManager.greyColor, width: 0.3),
                        borderRadius: BorderRadius.circular(30)),
                    child: Tab(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            category.type?.toString() ?? "",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: index == indexx
                                    ? FontWeight.w600
                                    : FontWeight.w500),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 14,
                              ),
                              5.pw,
                              Text(
                                "${category.startingTime.toString()}-${category.endingTime.toString()} ${category.unit.toString()}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: index == indexx
                                        ? FontWeight.bold
                                        : FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              );
            })),
      );
    });
  }
}
