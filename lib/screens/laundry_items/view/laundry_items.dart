import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/core/widgets/reusable_checkout_card.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/laundries/model/services_timings_model.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/laundry_items/components/attention_widget.dart';
import 'package:laundryday/screens/laundry_items/components/item_bottom_sheet_widget.dart';
import 'package:laundryday/screens/laundry_items/components/no_laundry_found.dart';
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_item_states.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_items.notifier.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/config/resources/api_routes.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/font_manager.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/widgets/my_loader.dart';
import 'package:laundryday/core/widgets/reuseable_laundry_detail_banner_card.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/screens/services/view/services.dart';

class LaundryItems extends ConsumerStatefulWidget {
  LaundryItems();

  @override
  ConsumerState<LaundryItems> createState() => _BlanketsCategoryState();
}

class _BlanketsCategoryState extends ConsumerState<LaundryItems> {
  @override
  void initState() {
    super.initState();
    final selectedAddress = ref.read(selectedAddressProvider);
    final selectedService = ref.read(serviceProvider).selectedService;

    Future.delayed(Duration(seconds: 0), () {
      ref.read(laundryItemProver.notifier).nearestLaundries(
          serviceId: selectedService!.id!,
          ref: ref,
          userLat: selectedAddress!.lat!,
          userLng: selectedAddress.lng!,
          context: context);

      ref
          .read(laundryItemProver.notifier)
          .categoriesWithItems(serviceId: selectedService.id!);
      ref.read(laundryItemProver.notifier).getCount();
      ref.read(laundryItemProver.notifier).getTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    final nearestLaundryStates =
        ref.watch(laundryItemProver).nearestLaundryStates;
    final categoryItemsStates =
        ref.watch(laundryItemProver).categoryItemsStates;
    final selectedCategory = ref.watch(laundryItemProver).selectedCategory;
    final count = ref.watch(laundryItemProver).count;
    final total = ref.watch(laundryItemProver).total;

    final selectedServiceTiming = ref.read(laundriessProvider).serviceTiming;
    final selectedService = ref.read(serviceProvider).selectedService;

    return Scaffold(
        body: Column(children: [
      if (nearestLaundryStates is NearestLaundryIntitialState) ...[
        Expanded(child: Loader())
      ] else if (nearestLaundryStates is NearestLaundryLoadingState) ...[
        Expanded(child: Loader())
      ] else if (nearestLaundryStates is NearestLaundryLoadedState) ...[
        nearestLaundryStates.laundryModel.data == null
            ? NoLaundryFound()
            : Expanded(
                child: Column(
                  children: [
                    ReusabelLaundryDetailBannerCard(
                      nearestLaundryModel: nearestLaundryStates.laundryModel,
                    ),
                    30.ph,
                    if (selectedService!.serviceName!.toLowerCase() ==
                        'clothes') ...[
                      AttentionWidget(
                        onTap: () {
                          Utils.showResuableBottomSheet(
                              context: context,
                              widget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  10.ph,
                                  Text(
                                    'No leather or wool items are allowed.',
                                    style: getSemiBoldStyle(
                                        fontSize: 18,
                                        color: ColorManager.blackColor),
                                  ),
                                  5.ph,
                                  Text(
                                    'Our prices are the same as the current laundry prices.All item are completely identical to the prices in the store wihout adding any increase by Laundry Day.',
                                    style: getSemiBoldStyle(
                                        fontSize: 16,
                                        color: ColorManager.greyColor),
                                  ),
                                  30.ph,
                                ],
                              ),
                              title: 'Attention');
                        },
                        message:
                            "Attention: No leather or wool items are allowed. Our prices are the same as the current laundry prices.",
                      )
                    ],
                    10.ph,
                    if (categoryItemsStates is CategoryItemsIntitialState) ...[
                      Expanded(child: Loader())
                    ] else if (categoryItemsStates
                        is CategoryItemsLoadingState) ...[
                      Expanded(child: Loader())
                    ] else if (categoryItemsStates
                        is CategoryItemsErrorState) ...[
                      Text(categoryItemsStates.errorMessage.toString())
                    ] else if (categoryItemsStates
                        is CategoryItemsLoadedState) ...[
                      categoryItemsStates.categoryItemModel.data!.length <= 1
                          ? SizedBox()
                          : CategoryTabBar(
                              categories:
                                  categoryItemsStates.categoryItemModel.data!,
                              ref: ref,
                              selectedCategory: selectedCategory,
                              selectedServiceTiming: selectedServiceTiming),
                      10.ph,
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: selectedCategory!.items!.length,
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p10,
                              vertical: AppPadding.p10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 160,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return _itemCard(
                                blanketItem: selectedCategory.items![index],
                                onTap: () {
                                  ref
                                      .read(laundryItemProver.notifier)
                                      .itemVariationsFromDB(
                                          itemId: selectedCategory
                                              .items![index].id!,
                                          serviceTimingId:
                                              selectedServiceTiming!.id!);

                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8))),
                                      context: context,
                                      builder: ((context) {
                                        return ItemBottomSheet(
                                          selectedItem:
                                              selectedCategory.items![index],
                                        );
                                      }));
                                });
                          },
                        ),
                      )
                    ]
                  ],
                ),
              )
      ] else if (nearestLaundryStates is NearestLaundryErrorState) ...[
        Text(nearestLaundryStates.errorMessage)
      ],
      10.ph,
      count > 0
          ? ReusableCheckOutCard(
              onPressed: () {
                context.pushNamed(RouteNames.orderReview, extra: {
                  'order_type': OrderType.normal,
                  'laundry': null,
                  'service': selectedService
                });
              },
              quantity: count.toString(),
              total: total.toStringAsFixed(2),
            )
          : const SizedBox(),
      20.ph,
    ]));
  }

  Widget _itemCard({void Function()? onTap, required Item blanketItem}) {
    return GestureDetector(
      onTap: onTap,
      child: Badge(
        isLabelVisible: blanketItem.count == null ? false : true,
        offset: Offset(-10, 10),
        label: Text(blanketItem.count.toString()),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 110,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side:
                          BorderSide(color: ColorManager.greyColor, width: 0.2),
                    ),
                    elevation: AppSize.s1_0,
                    child: Center(
                        child: CustomCacheNetworkImage(
                      imageUrl: Api.imageUrl + blanketItem.image.toString(),
                      height: AppSize.s65,
                    )),
                  ),
                ),
              ],
            ),
            4.ph,
            Text(
              blanketItem.name.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: getSemiBoldStyle(
                  color: ColorManager.blackColor, fontSize: FontSize.s12),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryTabBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        separatorBuilder: (context, index) => 10.pw,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          Item category = categories[index];

          return GestureDetector(
            onTap: () {
              ref
                  .read(laundryItemProver.notifier)
                  .changeIndex(catregory: category);
            },
            child: Container(
              width: 100,
              height: 18,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: category == selectedCategory
                          ? ColorManager.primaryColor
                          : ColorManager.lightGrey,
                      width: 1),
                  color: category == selectedCategory
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
                          color: category == selectedCategory
                              ? ColorManager.primaryColor
                              : ColorManager.greyColor,
                          fontSize: 10)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(
                      Icons.schedule,
                      size: AppSize.s12,
                      color: category == selectedCategory
                          ? ColorManager.primaryColor
                          : ColorManager.greyColor,
                    ),
                    5.pw,
                    Text(
                        "${selectedServiceTiming!.duration} ${selectedServiceTiming!.type}",
                        textAlign: TextAlign.center,
                        style: getSemiBoldStyle(
                            fontSize: FontSize.s9,
                            color: category == selectedCategory
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
