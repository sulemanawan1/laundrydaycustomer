import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/models/service_timings_model.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_items.notifier.dart';

class CategoryTabBar extends StatefulWidget {
  CategoryTabBar({
    super.key,
    required this.categories,
    required this.ref,
    required this.selectedCategory,
    required this.selectedServiceTiming,
  });

  final List<Item> categories;
  final WidgetRef ref;
  final Item? selectedCategory;
  final Datum? selectedServiceTiming;

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      widget.ref
          .read(laundryItemProver.notifier)
          .selectCategory(item: widget.categories.first);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        separatorBuilder: (context, index) => 10.pw,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (BuildContext context, int index) {
          Item category = widget.categories[index];

          return GestureDetector(
            onTap: () {
              widget.ref
                  .read(laundryItemProver.notifier)
                  .changeIndex(catregory: category);
            },
            child: Container(
              width: 100,
              height: 18,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: category == widget.selectedCategory
                          ? ColorManager.primaryColor
                          : ColorManager.lightGrey,
                      width: 1),
                  color: category == widget.selectedCategory
                      ? ColorManager.primaryColorOpacity10
                      : ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      overflow: TextOverflow.ellipsis,
                      category.name ?? "",
                      textAlign: TextAlign.center,
                      style: getSemiBoldStyle(
                          color: category == widget.selectedCategory
                              ? ColorManager.primaryColor
                              : ColorManager.greyColor,
                          fontSize: 10)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(
                      Icons.schedule,
                      size: AppSize.s12,
                      color: category == widget.selectedCategory
                          ? ColorManager.primaryColor
                          : ColorManager.greyColor,
                    ),
                    5.pw,
                    Text(
                        "${widget.selectedServiceTiming!.duration} ${widget.selectedServiceTiming!.type}",
                        textAlign: TextAlign.center,
                        style: getSemiBoldStyle(
                            fontSize: FontSize.s9,
                            color: category == widget.selectedCategory
                                ? ColorManager.primaryColor
                                : ColorManager.greyColor))
                  ])
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
