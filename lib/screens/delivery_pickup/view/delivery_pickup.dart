import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/screens/delivery_pickup/components/laundry_detail_card.dart';
import 'package:laundryday/screens/laundries/view/laundries.dart';
import 'package:laundryday/widgets/payment_summary_widget.dart';
import 'package:laundryday/screens/delivery_pickup/components/scan_receipt_widget.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_notifier.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_states.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/widgets/address_detail_widget.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/laundry_items/components/attention_widget.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

final deliverPickupProvider = StateNotifierProvider.autoDispose<
    DeliveryPickupNotifier,
    DeliveryPickupStates>((ref) => DeliveryPickupNotifier(ref: ref));

class DeliveryPickup extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLaundry = ref.read(laundriessProvider).selectedLaundry;
    final selectedService = ref.read(serviceProvider).selectedService;
    final isBlanketSelected =
        ref.watch(deliverPickupProvider).isBlanketSelected;
    final isCarpetSelected = ref.watch(deliverPickupProvider).isCarpetSelected;
    final itemIncluded = ref.watch(deliverPickupProvider).itemIncluded;
    final itemsExempt = ref.watch(deliverPickupProvider).itemsExempt;

    return Scaffold(
        appBar: MyAppBar(
          title: 'Delivery Pickup',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LaundryDetailCard(laundry: selectedLaundry!),
              AddressDetailCard(
                origin: selectedLaundry.destinationAddresses,
                destination: selectedLaundry.originAddresses,
              ),
              10.ph,
              ScanReceiptWidget(
                ref: ref,
              ),
              20.ph,
              // if (selectedService!.serviceName!.toLowerCase() ==

              //     ServiceTypes.clothes.name) ...[
              //   CheckboxListTile(
              //     contentPadding: EdgeInsets.zero,
              //     title: Text(
              //       'Do you have more than 7 items in your order?',
              //       style: getSemiBoldStyle(color: ColorManager.blackColor),
              //     ),
              //     value: itemsExempt,
              //     onChanged: (bool? value) {
              //       ref
              //           .read(deliverPickupProvider.notifier)
              //           .itemsExempt(itemsExempt: value!);
              //     },
              //   ),
              //   10.ph,
              //   AttentionWidget(
              //       onTap: () {
              //         Utils.showResuableBottomSheet(
              //             context: context,
              //             widget: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 10.ph,
              //                 Text(
              //                   'If your order includes any additional services besides this one, please make sure to select them.',
              //                   style: getSemiBoldStyle(
              //                       fontSize: 18,
              //                       color: ColorManager.blackColor),
              //                 ),
              //                 5.ph,
              //                 Text(
              //                   'By selecting an additional service, 10 SAR will be added to the total for each service selected.',
              //                   style: getSemiBoldStyle(
              //                       fontSize: 16,
              //                       color: ColorManager.greyColor),
              //                 ),
              //                 30.ph,
              //               ],
              //             ),
              //             title: 'Note');
              //       },
              //       message:
              //           'Note : If your order includes any additional services besides this one, please make sure to select them'),
              //   10.ph,
              //   if (isBlanketSelected == false &&
              //       isCarpetSelected == false) ...[
              //     CheckboxListTile(
              //       contentPadding: EdgeInsets.zero,
              //       title: Text(
              //         'Item Not Included',
              //         style: getSemiBoldStyle(color: ColorManager.blackColor),
              //       ),
              //       value: itemIncluded,
              //       onChanged: (bool? value) {
              //         ref
              //             .read(deliverPickupProvider.notifier)
              //             .selectitemIncluded(itemIncluded: value!);
              //       },
              //     ),
              //   ],
              //   if (itemIncluded == false) ...[
              //     CheckboxListTile(
              //       contentPadding: EdgeInsets.zero,
              //       title: Text(
              //         'Blanket  Included',
              //         style: getSemiBoldStyle(color: ColorManager.blackColor),
              //       ),
              //       value: isBlanketSelected,
              //       onChanged: (bool? value) {
              //         ref
              //             .read(deliverPickupProvider.notifier)
              //             .selectBlanket(isSelected: value!);
              //         ref.read(deliverPickupProvider.notifier).updateFees();
              //       },
              //     ),
              //     CheckboxListTile(
              //       contentPadding: EdgeInsets.zero,
              //       title: Text(
              //         'Carpet  Included',
              //         style: getSemiBoldStyle(color: ColorManager.blackColor),
              //       ),
              //       value: isCarpetSelected,
              //       onChanged: (bool? value) {
              //         ref
              //             .read(deliverPickupProvider.notifier)
              //             .selectCarpet(isSelected: value!);
              //         ref.read(deliverPickupProvider.notifier).updateFees();
              //       },
              //     ),
              //   ],
              //   10.ph,
              // ],
              PaymentSummaryText(
                  text1: 'Delivery Fee',
                  text2:
                      "${(selectedService!.deliveryFee! + selectedService.operationFee!).toStringAsFixed(2)}"),
              10.ph,
              MyButton(
                title: 'Next',
                onPressed: () {
                  log(itemIncluded.toString());

                  ref
                      .read(deliverPickupProvider.notifier)
                      .goToOrderReview(context: context);
                },
              ),
            ],
          ),
        ));
  }
}
