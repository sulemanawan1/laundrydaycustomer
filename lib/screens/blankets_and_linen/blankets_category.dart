import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/app_services/api_services.dart';
import 'package:laundryday/models/blankets_model.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/blankets_and_linen/provider/blanket_and_linen_notifier.dart';
import 'package:laundryday/screens/blankets_and_linen/provider/selected_item_count_notifier.dart';
import 'package:laundryday/screens/blankets_and_linen/provider/selected_items_notifier.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/utils/utils.dart';
import 'package:laundryday/utils/value_manager.dart';
import 'package:laundryday/widgets/my_heading/heading.dart';
import 'package:laundryday/widgets/my_loader/my_loader.dart';
import 'package:laundryday/widgets/reusable_checkout_card.dart';
import 'package:laundryday/widgets/reusable_service_category_tab_bar.dart';
import 'package:laundryday/widgets/reuseable_laundry_detail_banner_card.dart';

final blanketAndLinenFakeApiProvider =
    Provider<ApiServices>((ref) => ApiServices());

final blanketAndLinenProvider = StateNotifierProvider.autoDispose<
    BlanketAndLinenNotifier,
    List<LaundryItemModel>>((ref) => BlanketAndLinenNotifier(ref: ref));

final selectedItemNotifier =
    StateNotifierProvider<SelectedItemsNotifier, List<LaundryItemModel>>(
        (ref) => SelectedItemsNotifier(ref: ref));

final selectedItemsCountNotifier =
    StateNotifierProvider.autoDispose<SelectedItemCountNotifier, int>(
        (ref) => SelectedItemCountNotifier());

final isLoadingProductsProvider = StateProvider<bool>((ref) {
  return true;
});

int? categoryId;

class BlanketsCategory extends ConsumerStatefulWidget {
  final LaundryModel? laundry;

  const BlanketsCategory({super.key, required this.laundry});

  @override
  ConsumerState<BlanketsCategory> createState() => _BlanketsCategoryState();
}

class _BlanketsCategoryState extends ConsumerState<BlanketsCategory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();

    tabController =
        TabController(length: widget.laundry!.categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(selectedItemsCountNotifier);
    final index = ref.watch(indexProvider);

    return Scaffold(
        body: Column(children: [
      ReusabelLaundryDetailBannerCard(laundryModel: widget.laundry!),
      30.ph,

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.amber.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Attention: No leather or wool items are allowed.",
                  style: GoogleFonts.poppins(color: ColorManager.blackColor),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Our prices are the same as the current laundry prices.",
                        style:
                            GoogleFonts.poppins(color: ColorManager.blackColor),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Utils.showResuableBottomSheet(
                            context: context,
                            widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.ph,
                                Text(
                                  'No leather or wool items are allowed.',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                5.ph,
                                Text(
                                  'Our prices are the same as the current laundry prices.All item are completely identical to the prices in the store wihout adding any increase by Laundry Day.',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.greyColor),
                                ),
                                30.ph,
                              ],
                            ),
                            title: 'Attention');
                      },
                      child: Icon(
                        Icons.info,
                        color: Colors.amber.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      10.ph,
      widget.laundry!.categories.length == 1
          ? const SizedBox()
          : ReusableServiceCategoryTabBar(
              onTap: (v) {
                ref.read(indexProvider.notifier).state = v;
              },
              list: widget.laundry!.categories,
              tabController: tabController),

      Expanded(
        child: FutureBuilder(
            future: ref
                .read(blanketAndLinenProvider.notifier)
                .getAllLaundryItemCategory(
                    serviceId: widget.laundry!.service!.id,
                    categoryId: widget.laundry!.categories[index].id!),
            builder: (BuildContext context,
                AsyncSnapshot<List<LaundryItemModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return _blanketAndLinenItemCard(
                  item: snapshot.data!,
                );
              }
              return const Loader();
            }),
      ),
//       ref
//           .watch(blanketAndLinenItemsProvider(

//             Ids(serviceId: widget.laundry!.categories[index].serviceId!, categoryId:  widget.laundry!.categories[index].id!)
// ,
//           ))
//           .when(
//               data: (data) {
//                 return Expanded(
//                   child: _blanketAndLinenItemCard(
//                     item: data,
//                   ),
//                 );
//               },
//               error: (error, stackTrace) => const Loader(),
//               loading: () => const Loader()),
      count > 0
          ? ReusableCheckOutCard(
              onPressed: () {
                context.pushNamed(RouteNames().orderReview,
                    extra: Arguments(
                      laundryModel: widget.laundry,
                    ));
              },
              quantity: count.toString(),
              total: "100",
            )
          : const SizedBox(),
      20.ph,
    ]));
  }

  Widget _blanketAndLinenItemCard({required List<LaundryItemModel> item}) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: item.length,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p10, vertical: AppPadding.p10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 180,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _blanketCard(
            blanketItem: item[index],
            onTap: () {
              print(item[index].categoryId);

              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  context: context,
                  builder: ((context) {
                    ref
                        .read(blanketAndLinenProvider.notifier)
                        .fetchLaundryItemSubCategories(itemId: item[index].id!);

                    return Consumer(builder: (context, reff, child) {
                      return _blanketBottomSheetItem(
                          reff: reff, item: item[index]);
                    });
                  }));
            });
      },
    );
  }

  Widget _blanketCard(
      {void Function()? onTap, required LaundryItemModel blanketItem}) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 8, end: 8),
      badgeContent: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          '1',
          style: GoogleFonts.poppins(color: ColorManager.whiteColor),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 130,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side:
                          BorderSide(color: ColorManager.greyColor, width: 0.2),
                    ),
                    elevation: 1,
                    child: Center(
                        child: Image.asset(blanketItem.image.toString(),
                            width: 80, height: 80)),
                  ),
                ),
              ],
            ),
            4.ph,
            Text(
              blanketItem.name.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget _blanketBottomSheetItem(
      {required WidgetRef reff, required LaundryItemModel item}) {
    final blankets = reff.watch(blanketAndLinenProvider);
    final loader = reff.watch(isLoadingProductsProvider);

    return loader == false && blankets.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadingMedium(title: item.name.toString()),
                    IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: ColorManager.greyColor,
                        ))
                  ],
                ),
                Flexible(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => 10.ph,
                    shrinkWrap: true,
                    itemCount: blankets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 6,
                        child: ListTile(
                          trailing: quantityAddRemoveCard(
                              context: context,
                              blankets: blankets[index],
                              onTapRemoveQuantity: () {
                                reff
                                    .read(blanketAndLinenProvider.notifier)
                                    .removeQuantity(id: blankets[index].id);
                              },
                              onTapAddQuantity: () {
                                reff
                                    .read(blanketAndLinenProvider.notifier)
                                    .addQuantity(id: blankets[index].id);

                                reff
                                    .read(selectedItemNotifier.notifier)
                                    .checkAndUpdate(
                                        id: blankets[index].id,
                                        blankets: blankets[index],
                                        categoryId: item.categoryId);
                              }),
                          title: Text(
                            blankets[index].name.toString(),
                            maxLines: 2,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppPadding.p10),
                            child: Text(
                              "${blankets[index].initialCharges.toString()} SAR",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  color: ColorManager.blackColor),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                5.ph,
                GestureDetector(
                  onTap: () async {
                    reff.read(selectedItemsCountNotifier.notifier).state =
                        reff.read(selectedItemNotifier.notifier).state.length;

                    context.pop();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Heading(
                                  text: "SAR 0.0",
                                  color: ColorManager.whiteColor,
                                ),
                                Heading(
                                  text: 'Add',
                                  color: ColorManager.whiteColor,
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
                20.ph,
              ],
            ),
          )
        : const Loader();
  }

  Widget quantityAddRemoveCard(
      {required BuildContext context,
      required LaundryItemModel blankets,
      required void Function()? onTapRemoveQuantity,
      required void Function()? onTapAddQuantity}) {
    return Container(
      height: 30,
      decoration: ShapeDecoration(
          color: ColorManager.primaryColor.withOpacity(0.2),
          shape: const StadiumBorder()),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                constraints: const BoxConstraints(maxWidth: 30, minHeight: 30),
                padding: const EdgeInsets.only(left: 5),
                onPressed: onTapRemoveQuantity,
                icon: Icon(
                  Icons.remove,
                  color: ColorManager.blackColor,
                  size: 18,
                )),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 40, minWidth: 40),
              child: Center(
                child: Text(
                  blankets.quantity.toString(),
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            IconButton(
                constraints: const BoxConstraints(maxWidth: 30, minHeight: 30),
                padding: const EdgeInsets.only(right: 5),
                onPressed: onTapAddQuantity,
                icon: Icon(
                  Icons.add,
                  color: ColorManager.blackColor,
                  size: 18,
                )),
          ]),
    );
  }
}
