import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/screens/laundry_items/components/category_tabbar.dart';
import 'package:laundryday/screens/laundry_items/components/item_card.dart';
import 'package:laundryday/widgets/reusable_checkout_card.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/laundry_items/components/attention_widget.dart';
import 'package:laundryday/screens/laundry_items/components/item_bottom_sheet_widget.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_items.notifier.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/widgets/reuseable_laundry_detail_banner_card.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

class LaundryItems extends ConsumerStatefulWidget {
  LaundryItems();

  @override
  ConsumerState<LaundryItems> createState() => _LaundryItemsState();
}

class _LaundryItemsState extends ConsumerState<LaundryItems> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      ref.read(laundryItemProver.notifier).getCount();
      ref.read(laundryItemProver.notifier).getTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(laundryItemProver).selectedCategory;
    final count = ref.watch(laundryItemProver).count;
    final total = ref.watch(laundryItemProver).total;
    final selectedServiceTiming = ref.read(laundriessProvider).serviceTiming;
    final selectedLaundry = ref.read(laundriessProvider).selectedLaundry;
    final selectedLaundryByArea =
        ref.read(laundriessProvider).selectedLaundryByArea;
    final selectedService = ref.read(serviceProvider).selectedService;
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
        body: Column(children: [
      if (selectedService!.serviceName!.toLowerCase().trim() == 'carpets') ...[
        ReusabelLaundryDetailBannerCard(
          branchName: selectedLaundry!.name.toString(),
          rating: selectedLaundry.rating.toString(),
          serviceName: selectedService.serviceName.toString(),
          address: selectedLaundry.destinationAddresses,
          distance: selectedLaundry.distance,
          duration: selectedLaundry.duration,
        ),
      ] else if (selectedService.serviceName!.toLowerCase().trim() ==
          'clothes') ...[
        ReusabelLaundryDetailBannerCard(
          branchName: selectedLaundryByArea.name.toString(),
          rating: selectedLaundryByArea.rating.toString(),
          serviceName: selectedService.serviceName.toString(),
          address: selectedLaundryByArea.branch!.address.toString(),
          distance: selectedLaundryByArea.distance.toString(),
          duration: selectedLaundryByArea.duration.toString(),
        ),
      ] else if (selectedService.serviceName!.toLowerCase().trim() ==
          'blankets') ...[
        ReusabelLaundryDetailBannerCard(
          branchName: selectedLaundryByArea.name.toString(),
          rating: selectedLaundryByArea.rating.toString(),
          serviceName: selectedService.serviceName.toString(),
          address: selectedLaundryByArea.branch!.address.toString(),
          distance: selectedLaundryByArea.distance.toString(),
          duration: selectedLaundryByArea.duration.toString(),
        ),
      ],
      30.ph,
      if (selectedService.serviceName!.toLowerCase() == 'clothes') ...[
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
                          fontSize: 18, color: ColorManager.blackColor),
                    ),
                    5.ph,
                    Text(
                      'Our prices are the same as the current laundry prices.All item are completely identical to the prices in the store wihout adding any increase by Laundry Day.',
                      style: getSemiBoldStyle(
                          fontSize: 16, color: ColorManager.greyColor),
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
      categories.when(
          data: (data) {
            return data.fold((l) {
              return Text(l.toString());
            }, (r) {
              return CategoryTabBar(
                  categories: r.data!,
                  ref: ref,
                  selectedCategory: selectedCategory,
                  selectedServiceTiming: selectedServiceTiming);
            });
          },
          error: (e, s) => Text(
                e.toString(),
                style: getSemiBoldStyle(color: ColorManager.blackColor),
              ),
          loading: () => Loader()),
      10.ph,
      selectedCategory != null
          ? Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: selectedCategory.items!.length,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p10, vertical: AppPadding.p10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 160,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ItemCard(
                      item: selectedCategory.items![index],
                      onTap: () {
                        ref
                            .read(laundryItemProver.notifier)
                            .itemVariationsFromDB(
                                itemId: selectedCategory.items![index].id!,
                                serviceTimingId: selectedServiceTiming!.id!);

                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            context: context,
                            builder: ((context) {
                              return ItemBottomSheet(
                                selectedItem: selectedCategory.items![index],
                              );
                            }));
                      });
                },
              ),
            )
          : SizedBox(),
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
      20.ph
    ]));
  }
}
