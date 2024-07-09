
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/screens/laundry_items/components/attention_widget.dart';
import 'package:laundryday/screens/laundry_items/components/carpet_laundry_detail_widget.dart';
import 'package:laundryday/screens/laundry_items/components/item_lists.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_items.notifier.dart';
import 'package:laundryday/screens/laundry_items/provider/selected_item_count_notifier.dart';
import 'package:laundryday/screens/laundry_items/provider/selected_items_notifier.dart';
import 'package:laundryday/screens/delivery_pickup/view/delivery_pickup.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/widgets/reusable_checkout_card.dart';
import 'package:laundryday/widgets/reusable_service_category_tab_bar_widget.dart';
import 'package:laundryday/widgets/reuseable_laundry_detail_banner_card.dart';

final blanketAndLinenProvider =
    StateNotifierProvider.autoDispose<LaundryItemsNotifier, List<ItemModel>>(
        (ref) => LaundryItemsNotifier(ref: ref));

final selectedItemNotifier =
    StateNotifierProvider<SelectedItemsNotifier, List<ItemModel>>(
        (ref) => SelectedItemsNotifier(ref: ref));

final selectedItemsCountNotifier =
    StateNotifierProvider.autoDispose<SelectedItemCountNotifier, int>(
        (ref) => SelectedItemCountNotifier());

final isLoadingProductsProvider = StateProvider<bool>((ref) {
  return true;
});

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
        TabController(length: widget.laundry!.seviceTypes.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(selectedItemsCountNotifier);
    final index = ref.watch(indexProvider);

    return Scaffold(
        appBar: widget.laundry!.service!.name == 'Carpets'
            ? MyAppBar(title: '')
            : null,
        body: Column(children: [
          
          widget.laundry!.service!.name == 'Carpets'
              ? CarpetLaundryDetailWidget(laundryModel: widget.laundry!)
              : ReusabelLaundryDetailBannerCard(laundryModel: widget.laundry!),
          30.ph,
          widget.laundry!.service!.name == 'Clothes'
              ? const AttentionWidget()
              : const SizedBox(),
          10.ph,
          widget.laundry!.seviceTypes.length > 1
              ? ReusableServiceCategoryTabBar(
                  onTap: (v) {
                    ref.read(indexProvider.notifier).state = v;
                  },
                  list: widget.laundry!.seviceTypes,
                  tabController: tabController)
              : SizedBox(),
          Expanded(
            child: FutureBuilder(
                future: ref
                    .read(blanketAndLinenProvider.notifier)
                    .getAllLaundryItemCategory(
                        serviceId: widget.laundry!.service!.id,
                        categoryId: widget.laundry!.seviceTypes[index].id!),
                        
                builder: (BuildContext context,
                    AsyncSnapshot<List<ItemModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return ItemLists(
                      item: snapshot.data!,
                    );
                  }
                  return const Loader();
                }),
          ),
          count > 0
              ? ReusableCheckOutCard(
                  onPressed: () {
                    context.pushNamed(RouteNames().orderReview,
                        extra: Arguments(
                          laundryModel: widget.laundry,
                        ));
                  },
                  quantity: count.toString(),
                  total: "150",
                )
              : const SizedBox(),
          20.ph,
        ]));
  }
}
