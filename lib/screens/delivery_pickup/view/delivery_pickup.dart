import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
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
    final selectedLaundry = ref.read(laundriessProvider).selectedLaundry;
    final selectedService = ref.read(serviceProvider).selectedService;

    super.initState();

    Future.delayed(Duration(seconds: 0), () {
      ref.read(deliverPickupProvider.notifier).setDeliveryFee(
          distance: selectedLaundry!.distanceInKm,
          deliveryfee: selectedService!.deliveryFee!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deliveryfees = ref.watch(deliverPickupProvider).deliveryfees;
    final selectedLaundry = ref.read(laundriessProvider).selectedLaundry;
    final selectedService = ref.read(serviceProvider).selectedService;

    return Scaffold(
      appBar: MyAppBar(
        title: 'Delivery Pickup',
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.ph,
              LaundryDetailCard(laundry: selectedLaundry!),
              10.ph,
              AddressDetailCard(
                origin: selectedLaundry.destinationAddresses,
                destination: selectedLaundry.originAddresses,
              ),
              10.ph,
              ScanReceiptWidget(
                ref: ref,
              ),
              10.ph,
              PaymentSummaryText(
                  text1: 'Delivery Fee',
                  text2: "${deliveryfees.toStringAsFixed(2)} SAR"),
              Spacer(),
              MyButton(
                title: 'Next',
                onPressed: () {
                  ref.read(deliverPickupProvider.notifier).goToOrderReview(
                      laundry: selectedLaundry,
                      service: selectedService!,
                      context: context);
                },
              ),
              10.ph
            ],
          ),
        );
      }),
    );
  }
}

class LaundryDetailCard extends StatelessWidget {
  DeliveryPickupLaundryModel laundry;
  LaundryDetailCard({super.key, required this.laundry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: ColorManager.whiteColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    laundry.name.toString(),
                    style: getMediumStyle(
                        color: ColorManager.blackColor, fontSize: 14),
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
                          Text(laundry.rating.toString()),
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
            10.ph,
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
            10.ph,
          ]),
        ),
      ),
    );
  }
}
