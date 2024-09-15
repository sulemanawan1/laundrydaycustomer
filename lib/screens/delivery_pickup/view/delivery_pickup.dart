import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/core/widgets/payment_summary_widget.dart';
import 'package:laundryday/screens/delivery_pickup/components/scan_receipt_widget.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_notifier.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_states.dart';
import 'package:laundryday/screens/laundries/model/delivery_pickup_laundry_model.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/core/widgets/address_detail_widget.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/laundry_items/components/attention_widget.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

enum OrderType { delivery_pickup, normal }

final deliverPickupProvider = StateNotifierProvider.autoDispose<
    DeliveryPickupNotifier,
    DeliveryPickupStates>((ref) => DeliveryPickupNotifier(ref: ref));

class DeliveryPickup extends ConsumerStatefulWidget {
  DeliveryPickup({
    super.key,
  });

  @override
  ConsumerState<DeliveryPickup> createState() => _DeliveryPickupState();
}

class _DeliveryPickupState extends ConsumerState<DeliveryPickup> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedLaundry = ref.read(laundriessProvider).selectedLaundry;
    final selectedService = ref.read(serviceProvider).selectedService;

    final isBlanketSelected =
        ref.watch(deliverPickupProvider).isBlanketSelected;
    final isCarpetSelected = ref.watch(deliverPickupProvider).isCarpetSelected;
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
              10.ph,
              AttentionWidget(
                  onTap: () {
                    Utils.showResuableBottomSheet(
                        context: context,
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.ph,
                            Text(
                              'If your order includes any additional services besides this one, please make sure to select them.',
                              style: getSemiBoldStyle(
                                  fontSize: 18, color: ColorManager.blackColor),
                            ),
                            5.ph,
                            Text(
                              'By selecting an additional service, 10 SAR will be added to the total for each service selected.',
                              style: getSemiBoldStyle(
                                  fontSize: 16, color: ColorManager.greyColor),
                            ),
                            30.ph,
                          ],
                        ),
                        title: 'Note');
                  },
                  message:
                      'Note : If your order includes any additional services besides this one, please make sure to select them'),
              10.ph,
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Blanket  Included',
                  style: getSemiBoldStyle(color: ColorManager.blackColor),
                ),
                value: isBlanketSelected,
                onChanged: (bool? value) {
                  ref
                      .read(deliverPickupProvider.notifier)
                      .selectBlanket(isSelected: value!);
                  ref.read(deliverPickupProvider.notifier).updateFees();
                },
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Carpet  Included',
                  style: getSemiBoldStyle(color: ColorManager.blackColor),
                ),
                value: isCarpetSelected,
                onChanged: (bool? value) {
                  ref
                      .read(deliverPickupProvider.notifier)
                      .selectCarpet(isSelected: value!);
                  ref.read(deliverPickupProvider.notifier).updateFees();
                },
              ),
              10.ph,
              PaymentSummaryText(
                  text1: 'Delivery Fee',
                  text2:
                      "${(selectedService!.deliveryFee! + selectedService.operationFee!).toStringAsFixed(2)}"),
              10.ph,
              MyButton(
                title: 'Next',
                onPressed: () {
                  ref
                      .read(deliverPickupProvider.notifier)
                      .goToOrderReview(context: context);
                },
              ),
              10.ph
            ],
          ),
        ));
  }
}

class LaundryDetailCard extends StatelessWidget {
  final DeliveryPickupLaundryModel laundry;
  LaundryDetailCard({super.key, required this.laundry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: ColorManager.silverWhite,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            8.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    laundry.name.toString(),
                    style: getMediumStyle(color: ColorManager.blackColor),
                  ),
                ),
                laundry.rating == null
                    ? SizedBox()
                    : Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber,
                          ),
                          2.pw,
                          Text(
                            laundry.rating.toString(),
                            style:
                                getRegularStyle(color: ColorManager.blackColor),
                          ),
                          4.pw,
                          Text(
                            'Reviews',
                            style: getMediumStyle(
                                color: ColorManager.primaryColor),
                          )
                        ],
                      )
              ],
            ),
            8.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.directions_walk,
                      size: 14,
                      color: ColorManager.primaryColor,
                    ),
                    10.pw,
                    Text(
                      "7- 20 min",
                      style: getMediumStyle(color: ColorManager.greyColor),
                    ),
                  ],
                ),
                // Text(
                //   '${widget.laundry.distance.toString()} km',
                //   style: GoogleFonts.poppins(color: ColorManager.greyColor),
                // ),
              ],
            ),
            8.ph,
          ]),
        ),
      ),
    );
  }
}
