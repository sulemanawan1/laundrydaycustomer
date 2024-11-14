import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/provider/user_notifier.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/screens/offers/provider/offers_notifier.dart';
import 'package:laundryday/screens/offers/view/offers.dart';
import 'package:laundryday/screens/subscription/provider/subscription_notifier.dart';
import 'package:laundryday/screens/subscription_laundry/provider/subscription_laundry_notifier.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';

class Subscription extends ConsumerWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(offerProvider).subscriptionPlanModel;
    final userId = ref.watch(userProvider).userModel!.user!.id!;
    var selectedBranch = ref.watch(subscriptionLaundryProvider).selectedBranch;
    LatLng? userLatLng = ref.watch(subscriptionLaundryProvider).initialLatLng;
    return Scaffold(
      appBar: MyAppBar(
        title: 'Subscription',
      ),
      body: Column(
        children: [
          Card(
            color: ColorManager.silverWhite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    20.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Plan',
                          style: getSemiBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s12),
                        ),
                        Text(
                          plan!.name.toString(),
                          style: getMediumStyle(color: ColorManager.blackColor),
                        ),
                      ],
                    ),
                    20.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Days',
                          style: getSemiBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s12),
                        ),
                        Text(
                          getDaysForMonths(plan.durationInMonths!).toString(),
                          style: getMediumStyle(color: ColorManager.blackColor),
                        ),
                      ],
                    ),
                    20.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Type',
                          style: getSemiBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s12),
                        ),
                        Text(
                          plan.type.toString(),
                          style: getMediumStyle(color: ColorManager.blackColor),
                        ),
                      ],
                    ),
                    20.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Feature',
                          style: getSemiBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s12),
                        ),
                        Text(
                          getFeatures(planName: plan.name!),
                          style: getMediumStyle(color: ColorManager.blackColor),
                        ),
                      ],
                    ),
                    20.ph,
                    MyButton(
                      title: 'Subscribe ${plan.amount} SAR',
                      onPressed: () {
                        Map data = {
                          "user_id": userId,
                          "subscription_plan_id": plan.id,
                          "branch_name": selectedBranch!.name!,
                          "branch_address": selectedBranch.vicinity,
                          "branch_lat": selectedBranch.lat,
                          "branch_lng": selectedBranch.lng,
                          "user_lat": userLatLng!.latitude,
                          "user_lng": userLatLng.longitude,
                          // "user_address": "Al Mahamid AhHazhm"
                        };
                        ref
                            .read(subscriptionProvider.notifier)
                            .createSubscription(
                                data: data, context: context, ref: ref);
                      },
                    ),
                    20.ph,
                  ]),
            ),
          ),
          // Card(
          //   color: ColorManager.silverWhite,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           20.ph,
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Plan',
          //                 style: getSemiBoldStyle(
          //                     color: ColorManager.blackColor,
          //                     fontSize: FontSize.s12),
          //               ),
          //               Text(
          //                 activeSubscription.subscriptionPlan!.name.toString(),
          //                 style: getMediumStyle(color: ColorManager.blackColor),
          //               ),
          //             ],
          //           ),
          //           20.ph,
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Subscription Area',
          //                 style: getSemiBoldStyle(
          //                     color: ColorManager.blackColor,
          //                     fontSize: FontSize.s12),
          //               ),
          //               Text(
          //                 activeSubscription
          //                     .subscriptionDetail!.district!.nameEn!
          //                     .toString(),
          //                 style: getMediumStyle(color: ColorManager.blackColor),
          //               ),
          //             ],
          //           ),
          //           20.ph,
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Type',
          //                 style: getSemiBoldStyle(
          //                     color: ColorManager.blackColor,
          //                     fontSize: FontSize.s12),
          //               ),
          //               Text(
          //                 activeSubscription.subscriptionPlan!.subscriptionType!
          //                     .toString(),
          //                 style: getMediumStyle(color: ColorManager.blackColor),
          //               ),
          //             ],
          //           ),
          //           20.ph,
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Start Date',
          //                 style: getSemiBoldStyle(
          //                     color: ColorManager.blackColor,
          //                     fontSize: FontSize.s12),
          //               ),
          //               Text(
          //                 DateHelper.formatDate(
          //                     activeSubscription.startTime!.toString()),
          //                 style: getMediumStyle(color: ColorManager.blackColor),
          //               ),
          //             ],
          //           ),
          //           20.ph,
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'End Date',
          //                 style: getSemiBoldStyle(
          //                     color: ColorManager.blackColor,
          //                     fontSize: FontSize.s12),
          //               ),
          //               Text(
          //                 DateHelper.formatDate(
          //                     activeSubscription.endTime!.toString()),
          //                 style: getMediumStyle(color: ColorManager.blackColor),
          //               ),
          //             ],
          //           ),
          //           20.ph,
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Updated at',
          //                 style: getSemiBoldStyle(
          //                     color: ColorManager.blackColor,
          //                     fontSize: FontSize.s12),
          //               ),
          //               Text(
          //                 DateHelper.formatDateTime(activeSubscription
          //                     .updatedAt!
          //                     .toUtc()
          //                     .add(const Duration(hours: 3))
          //                     .toString()),
          //                 style: getMediumStyle(color: ColorManager.blackColor),
          //               ),
          //             ],
          //           ),
          //           20.ph,
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Status',
          //                 style: getSemiBoldStyle(
          //                     color: ColorManager.blackColor,
          //                     fontSize: FontSize.s12),
          //               ),
          //               Text(
          //                 activeSubscription.status.toString().toUpperCase(),
          //                 style: getMediumStyle(color: ColorManager.blackColor),
          //               ),
          //             ],
          //           ),
          //           20.ph,
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'Next Billing Date\n${DateHelper.formatDate(DateHelper.getNextMonthDate(activeSubscription.endTime!).toString())}',
          //                 style: getSemiBoldStyle(
          //                     color: ColorManager.blackColor,
          //                     fontSize: FontSize.s12),
          //               ),
          //               InkWell(
          //                 onTap: () {
          //                   // Utils.showReusableDialog(
          //                   //     context: context,
          //                   //     title:
          //                   //         'Are you sure you want to cancel subscription?',
          //                   //     widget: Column(
          //                   //       mainAxisSize: MainAxisSize.min,
          //                   //       children: [
          //                   //         10.ph,
          //                   //         Text(
          //                   //           'Your Subscription will be cancelled immediately.',
          //                   //           style: getMediumStyle(
          //                   //               color: ColorManager.greyColor,
          //                   //               fontSize: FontSize.s10),
          //                   //         ),
          //                   //         20.ph,
          //                   //         MyButton(
          //                   //             color: ColorManager.lightGrey,
          //                   //             textColor: ColorManager.blackColor,
          //                   //             onPressed: () {
          //                   //               context.pop();
          //                   //             },
          //                   //             title: 'Keep Subscription'),
          //                   //         20.ph,
          //                   //         MyButton(
          //                   //             color: ColorManager.redColor,
          //                   //             onPressed: () {
          //                   //               ref
          //                   //                   .read(yourAreaController.notifier)
          //                   //                   .cancelSubscription(
          //                   //                       planId:
          //                   //                           activeSubscription.id!,
          //                   //                       context: context,
          //                   //                       ref: ref);
          //                   //             },
          //                   //             title: 'Cancel Subscription'),
          //                   //         20.ph,
          //                   //       ],
          //                   //     ));
          //                 },
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: Text(
          //                     'Cancel Subscription',
          //                     style: getSemiBoldStyle(
          //                         color: ColorManager.redColor,
          //                         fontSize: FontSize.s10),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           20.ph,
          //         ]),
          //   ),
          // ),
        ],
      ),
    );
  }
}
