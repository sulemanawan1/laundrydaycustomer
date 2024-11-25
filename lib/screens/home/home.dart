import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/constants/font_manager.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/screens/home/provider/home_notifier.dart';
import 'package:laundryday/screens/more/more.dart';
import 'package:laundryday/screens/offers/view/offers.dart';
import 'package:laundryday/screens/orders/orders.dart';
import 'package:laundryday/screens/services/view/services.dart';
import 'package:laundryday/constants/colors.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(homeProvider).index;
    return PopScope(
      canPop: false, //When false, blocks the current route from being popped.
      onPopInvoked: (didpop) async {
        if (didpop) {
          return;
        }

        Utils.showReusableDialog(
            context: context,
            title: 'Laundry Day',
            description: 'Do you want to close the app ?',
            buttons: [
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text("Cancel",
                      style: getSemiBoldStyle(color: ColorManager.greyColor))),
              TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text(
                    "Close",
                    style: getSemiBoldStyle(color: ColorManager.nprimaryColor),
                  )),
            ]);
      },
      child: Scaffold(
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
          )),
    );
  }
}
