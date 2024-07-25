import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/laundry_items/components/attention_widget.dart';
import 'package:laundryday/screens/laundry_items/components/item_bottom_sheet_widget.dart';
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_item_states.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_items.notifier.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/core/constants/api_routes.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/font_manager.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/constants/value_manager.dart';
import 'package:laundryday/core/theme/styles_manager.dart';
import 'package:laundryday/core/widgets/my_loader.dart';
import 'package:laundryday/core/widgets/reuseable_laundry_detail_banner_card.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;

class LaundryItems extends ConsumerStatefulWidget {
  servicemodel.Datum? services;
  LaundryItems({required this.services});

  @override
  ConsumerState<LaundryItems> createState() => _BlanketsCategoryState();
}

class _BlanketsCategoryState extends ConsumerState<LaundryItems> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      final selectedAddress = ref.read(selectedAddressProvider);
      ref.read(laundryItemProver.notifier).nearestLaundries(
          serviceId: widget.services!.id!,
          ref: ref,
          userLat: selectedAddress!.lat!,
          userLng: selectedAddress.lng!,
          context: context);

      ref
          .read(laundryItemProver.notifier)
          .categoriesWithItems(serviceId: widget.services!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final nearestLaundryStates =
        ref.watch(laundryItemProver).nearestLaundryStates;
    final categoryItemsStates =
        ref.watch(laundryItemProver).categoryItemsStates;
    final selectedCategory = ref.watch(laundryItemProver).selectedCategory;

    final selectedServiceTiming = ref.read(laundriessProvider).serviceTiming;
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
                    if (widget.services!.serviceName!.toLowerCase() ==
                        'clothes') ...[AttentionWidget()],
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
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => 10.pw,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryItemsStates
                              .categoryItemModel.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Datum category = categoryItemsStates
                                .categoryItemModel.data![index];

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.schedule,
                                            size: AppSize.s12,
                                            color: category == selectedCategory
                                                ? ColorManager.primaryColor
                                                : ColorManager.greyColor,
                                          ),
                                          5.pw,
                                          Text('24 hour',
                                              textAlign: TextAlign.center,
                                              style: getSemiBoldStyle(
                                                  fontSize: FontSize.s9,
                                                  color: category ==
                                                          selectedCategory
                                                      ? ColorManager
                                                          .primaryColor
                                                      : ColorManager.greyColor))
                                        ])
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
                                      .itemVariations(
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
                                        return ItemBottomSheet();
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

      // count > 0
      //     ? ReusableCheckOutCard(
      //         onPressed: () {
      //           context.pushNamed(RouteNames().orderReview,
      //               extra: Arguments(
      //                 laundryModel: widget.laundry,
      //               ));
      //         },
      //         quantity: count.toString(),
      //         total: "150",
      //       )
      //     : const SizedBox(),
      20.ph,
    ]));
  }

  Widget _itemCard({void Function()? onTap, required Datum blanketItem}) {
    return GestureDetector(
      onTap: onTap,
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
                    side: BorderSide(color: ColorManager.greyColor, width: 0.2),
                  ),
                  elevation: AppSize.s1_0,
                  child: Center(
                      child: Image.network(
                          Api.imageUrl + blanketItem.image.toString(),
                          width: AppSize.s65,
                          height: AppSize.s65)),
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
    );
  }
}

class NoLaundryFound extends StatelessWidget {
  const NoLaundryFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/no_data.png',
              width: 100,
            ),
            Text(
              "No Laundry Found",
              style:
                  getMediumStyle(color: ColorManager.blackColor, fontSize: 14),
            ),
            OutlinedButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  "Go to Home Screen",
                  style: getMediumStyle(color: ColorManager.purpleColor),
                ))
          ],
        ),
      ),
    );
  }
}
