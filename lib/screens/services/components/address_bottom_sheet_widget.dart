import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/blankets_and_linen/blankets_category.dart';
import 'package:laundryday/screens/services/view/services.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/sized_box.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/heading.dart';

class AddressBottomSheetWidget extends ConsumerWidget {
  final ServicesModel? servicesModel;
  const AddressBottomSheetWidget({super.key, this.servicesModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.watch(serviceProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          10.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Heading(text: 'Choose from saved addresses'),
              IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: ColorManager.greyColor,
                  ))
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: ((context, index) => 18.ph),
              itemCount: states.address.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: (states.addressSelectedIndex == index)
                              ? ColorManager.primaryColor
                              : ColorManager.greyColor)),
                  child: ListTile(
                    tileColor: (states.addressSelectedIndex == index)
                        ? ColorManager.primaryColorOpacity10
                        : null,
                    title: Text(states.address[index].name.toString()),
                    subtitle: Text(states.address[index].address.toString()),
                    onTap: () {
                      ref
                          .read(serviceProvider.notifier)
                          .selectIndex(index: index);

                      if (servicesModel?.name.toString() == 'Blankets') {
                        log(servicesModel!.deliveryFee.toString());

                        ref.read(selectedItemNotifier.notifier).state.clear();

                        GoRouter.of(context).pushNamed(
                            RouteNames().blanketAndLinenServiceDetail,
                            extra: servicesModel);

                        context.pop();
                      } else if (servicesModel?.name.toString() == "Carpets") {
                        print(servicesModel!.deliveryFee);
                        GoRouter.of(context).pushNamed(
                            RouteNames().serviceDetail,
                            extra: servicesModel);

                        context.pop();
                      } else if (servicesModel?.name.toString() == "Clothes") {
                        log(servicesModel!.id.toString());
                        log(servicesModel!.deliveryFee.toString());

                        ref.read(selectedItemNotifier.notifier).state.clear();

                        GoRouter.of(context).pushNamed(
                            RouteNames().blanketAndLinenServiceDetail,
                            extra: servicesModel);
                        context.pop();
                      }
                    },
                    leading: (states.addressSelectedIndex == index)
                        ? Icon(
                            Icons.check_circle_rounded,
                            color: ColorManager.primaryColor,
                          )
                        : const Icon(Icons.circle_outlined),
                  ),
                );
              },
            ),
          ),
          5.ph,
          MyButton(
            name: 'Add Address',
            isBorderButton: true,
            onPressed: () {
              context.pushNamed(RouteNames().addNewAddress);

              context.pop();
            },
          ),
          20.ph
        ],
      ),
    );
  }
}
