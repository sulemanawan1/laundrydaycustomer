import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/constants/sized_box.dart';
import 'package:laundryday/shared/provider/distance_details_notifier.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/widgets/payment_summary_widget.dart';
import 'package:laundryday/screens/delivery_pickup/components/scan_receipt_widget.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_notifier.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_states.dart';
import 'package:laundryday/constants/value_manager.dart';
import 'package:laundryday/widgets/address_detail_widget.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/screens/laundries/provider/laundries_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';

final deliverPickupProvider = StateNotifierProvider.autoDispose<
    DeliveryPickupNotifier,
    DeliveryPickupStates>((ref) => DeliveryPickupNotifier());

class DeliveryPickup extends ConsumerWidget {
  final DistanceDataModel distanceDataModel;
  DeliveryPickup({required this.distanceDataModel});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLaundry = ref.read(laundriessProvider).selectedLaundry;
    final selectedService = ref.read(serviceProvider).selectedService;
    final distanceData = ref.watch(distanceDetailProvider);

    return Scaffold(
        appBar: MyAppBar(
          title: 'Delivery Pickup',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ref.watch(distanceProvider(distanceDataModel)).when(
                  data: (data) {
                    Future.delayed(Duration(seconds: 0), () {
                      ref.read(distanceDetailProvider.notifier).state = data!;
                    });
                    return Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: ColorManager.silverWhite,
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                8.ph,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        selectedLaundry!.name.toString(),
                                        style: getMediumStyle(
                                            color: ColorManager.blackColor),
                                      ),
                                    ),
                                    selectedLaundry.rating == null
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
                                                selectedLaundry.rating
                                                    .toString(),
                                                style: getRegularStyle(
                                                    color: ColorManager
                                                        .blackColor),
                                              ),
                                              4.pw,
                                              Text(
                                                'Reviews',
                                                style: getMediumStyle(
                                                    color: ColorManager
                                                        .primaryColor),
                                              )
                                            ],
                                          )
                                  ],
                                ),
                                8.ph,
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: ColorManager.primaryColor,
                                    ),
                                    10.pw,
                                    Text(
                                      "${data!.distanceText}",
                                      style: getMediumStyle(
                                          color: ColorManager.greyColor),
                                    ),
                                  ],
                                ),
                                8.ph,
                              ]),
                            ),
                          ),
                        ),
                        AddressDetailCard(
                          origin: data.destination_addresses,
                          destination: data.originAddresses,
                        ),
                      ],
                    );
                  },
                  error: (e, s) => Text(s.toString()),
                  loading: () => Loader()),
              10.ph,
              ScanReceiptWidget(
                ref: ref,
              ),
              20.ph,
              PaymentSummaryText(
                  text1: 'Delivery Fee',
                  text2:
                      "${(selectedService!.deliveryFee! + selectedService.operationFee!).toStringAsFixed(2)}"),
              10.ph,
              distanceData != null
                  ? MyButton(
                      title: 'Next',
                      onPressed: () {

                        
                        ref
                            .read(deliverPickupProvider.notifier)
                            .goToOrderReview(context: context);
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ));
  }
}
