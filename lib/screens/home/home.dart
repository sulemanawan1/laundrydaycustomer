import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/screens/home/provider/home_notifier.dart';
import 'package:laundryday/screens/more/more.dart';
import 'package:laundryday/screens/offers/view/offers.dart';
import 'package:laundryday/screens/orders/orders.dart';
import 'package:laundryday/screens/services/view/services.dart';
import 'package:laundryday/resources/colors.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(homeProvider).index;
    return Scaffold(
        backgroundColor: ColorManager.whiteColor,
        bottomNavigationBar: Card(
          elevation: AppSize.s0,
          color: ColorManager.whiteColor,
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: (inded) {
              ref
                  .read(homeProvider.notifier)
                  .changeIndex(index: inded, ref: ref);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_offer),
                label: 'Offers',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz_sharp),
                label: 'More',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorManager.primaryColor,
            backgroundColor: ColorManager.whiteColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedLabelStyle: getSemiBoldStyle(
                fontSize: FontSize.s16, color: ColorManager.blackColor),
            unselectedLabelStyle: getSemiBoldStyle(
                fontSize: FontSize.s16, color: ColorManager.blackColor),
          ),
        ),
        body: IndexedStack(
          index: index,
          children: [Services(), Orders(), Offers(), More()],
        ));
  }
}
