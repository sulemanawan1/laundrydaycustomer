import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/helpers/date_helper.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/font_manager.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/resources/value_manager.dart';
import 'package:laundryday/screens/offers/provider/offers_notifier.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:laundryday/widgets/my_textform_field.dart';

import '../../../core/utils.dart';

class Offers extends ConsumerWidget {
  Offers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(fetchUserProvider);
    final subscriptionPlans = ref.watch(subscriptionPlanProvider);
    final subscriptionPlanModel =
        ref.watch(offerProvider).subscriptionPlanModel;
    var activeSubscription = ref.watch(activeUserSubscriptionProvider);

    return Scaffold(
        appBar: MyAppBar(
          title: 'Offers',
          isLeading: false,
        ),
        body: userDetails.when(
            data: (data) {
              return data.fold((l) => Text(l), (r) {
                if (r.user!.subscriptionStatus == null ||
                    r.user!.subscriptionStatus == 'not_subscribed') {
                  return subscriptionPlans.when(
                      data: (data) {
                        return data.fold((l) {
                          return Text(l);
                        }, (r) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Heading(title: 'Select Your Plan'),
                                  10.ph,
                                  Center(
                                    child: Image.asset(
                                      'assets/vectors/subscription.png',
                                      height: 180,
                                    ),
                                  ),
                                  20.ph,
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p10),
                                    itemCount: r.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var plan = r.data![index];
                                      return GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(offerProvider.notifier)
                                              .selectSubscription(
                                                  selectedSubscription: plan);

                                          if (subscriptionPlanModel != null) {
                                            context.pushNamed(
                                              RouteNames.subscriptionLaundry,
                                            );
                                          }
                                        },
                                        child: Card(
                                          elevation: 0,
                                          color: ColorManager.mediumWhiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: [
                                                10.ph,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: getColor(
                                                              planName:
                                                                  plan.name!)),
                                                      child: Center(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          plan.name.toString(),
                                                          style: getBoldStyle(
                                                              fontSize: 12,
                                                              color: ColorManager
                                                                  .whiteColor),
                                                        ),
                                                      )),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'SAR ${plan.amount}',
                                                          style: getSemiBoldStyle(
                                                              fontSize: 14,
                                                              color: ColorManager
                                                                  .blackColor),
                                                        ),
                                                        5.ph,
                                                        TextButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    WidgetStateColor.resolveWith((states) =>
                                                                        getColor(
                                                                            planName:
                                                                                plan.name!))),
                                                            onPressed: () {},
                                                            child: Text(
                                                              'Subscribe',
                                                              style:
                                                                  getSemiBoldStyle(
                                                                fontSize: 10,
                                                                color: ColorManager
                                                                    .whiteColor,
                                                              ),
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icons/delivery_agent.png',

                                                          width: 40,
                                                          // ignore: deprecated_member_use
                                                        ),
                                                        5.pw,
                                                        Text(
                                                          getFeatures(
                                                              planName:
                                                                  plan.name!),
                                                          style:
                                                              getSemiBoldStyle(
                                                            color: ColorManager
                                                                .greyColor,
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.calendar_month,
                                                          color: ColorManager
                                                              .greyColor,
                                                          size: 12,
                                                        ),
                                                        5.pw,
                                                        Text(
                                                          '${getDaysForMonths(plan.durationInMonths!)}  Days',
                                                          style: getSemiBoldStyle(
                                                              color: ColorManager
                                                                  .greyColor,
                                                              fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                10.ph,
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                      error: (e, stackTrace) {
                        return Text(e.toString());
                      },
                      loading: () => const Loader());
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        activeSubscription.when(
                            data: (data) => data.fold((l) => Text(l), (r) {
                                  var activeSubscription = r.data;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p10),
                                    child: Column(
                                      children: [
                                        // SizedBox(
                                        //   height: 300,
                                        //   child: GoogleMap(
                                        //     initialCameraPosition:
                                        //         CameraPosition(
                                        //             target: initialPosition,
                                        //             zoom: 14),
                                        //     polygons: polygons,
                                        //     onMapCreated: (GoogleMapController
                                        //         gcontroller) {
                                        //       googleMapController = gcontroller;
                                        //     },
                                        //   ),
                                        // ),
                                        20.ph,

                                        Card(
                                          color: ColorManager.silverWhite,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  20.ph,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Plan',
                                                        style: getSemiBoldStyle(
                                                            color: ColorManager
                                                                .blackColor,
                                                            fontSize:
                                                                FontSize.s12),
                                                      ),
                                                      Text(
                                                        activeSubscription!
                                                            .subscriptionPlan!
                                                            .name
                                                            .toString(),
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  20.ph,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Type',
                                                        style: getSemiBoldStyle(
                                                            color: ColorManager
                                                                .blackColor,
                                                            fontSize:
                                                                FontSize.s12),
                                                      ),
                                                      Text(
                                                        activeSubscription
                                                            .subscriptionPlan!
                                                            .subscriptionType!
                                                            .toString(),
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  20.ph,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Start Date',
                                                        style: getSemiBoldStyle(
                                                            color: ColorManager
                                                                .blackColor,
                                                            fontSize:
                                                                FontSize.s12),
                                                      ),
                                                      Text(
                                                        DateHelper.formatDate(
                                                            activeSubscription
                                                                .startTime!
                                                                .toString()),
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  20.ph,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'End Date',
                                                        style: getSemiBoldStyle(
                                                            color: ColorManager
                                                                .blackColor,
                                                            fontSize:
                                                                FontSize.s12),
                                                      ),
                                                      Text(
                                                        DateHelper.formatDate(
                                                            activeSubscription
                                                                .endTime!
                                                                .toString()),
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  20.ph,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Status',
                                                        style: getSemiBoldStyle(
                                                            color: ColorManager
                                                                .blackColor,
                                                            fontSize:
                                                                FontSize.s12),
                                                      ),
                                                      Text(
                                                        activeSubscription
                                                            .status
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  20.ph,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Next Billing Date\n${DateHelper.formatDate(DateHelper.getNextMonthDate(activeSubscription.endTime!).toString())}',
                                                        style: getSemiBoldStyle(
                                                            color: ColorManager
                                                                .blackColor,
                                                            fontSize:
                                                                FontSize.s12),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          // Utils.showReusableDialog(
                                                          //     context: context,
                                                          //     title: 'Are you sure you want to cancel subscription?',
                                                          //     widget: Column(
                                                          //       mainAxisSize:
                                                          //           MainAxisSize
                                                          //               .min,
                                                          //       children: [
                                                          //         10.ph,
                                                          //         Text(
                                                          //           'Your Subscription will be cancelled immediately.',
                                                          //           style: getMediumStyle(
                                                          //               color: ColorManager
                                                          //                   .greyColor,
                                                          //               fontSize:
                                                          //                   FontSize.s10),
                                                          //         ),
                                                          //         20.ph,
                                                          //         MyButton(
                                                          //             color: ColorManager
                                                          //                 .lightGrey,
                                                          //             textColor:
                                                          //                 ColorManager
                                                          //                     .blackColor,
                                                          //             onPressed:
                                                          //                 () {
                                                          //               context
                                                          //                   .pop();
                                                          //             },
                                                          //             title:
                                                          //                 'Keep Subscription'),
                                                          //         20.ph,
                                                          //         MyButton(
                                                          //             color: ColorManager
                                                          //                 .redColor,
                                                          //             onPressed:
                                                          //                 () {
                                                          //               // ref.read(yourAreaController.notifier).cancelSubscription(
                                                          //               //     planId: activeSubscription
                                                          //               //         .id!,
                                                          //               //     context:
                                                          //               //         context,
                                                          //               //     ref:
                                                          //               //         ref);
                                                          //             },
                                                          //             title:
                                                          //                 'Cancel Subscription'),
                                                          //         20.ph,
                                                          //       ],
                                                          //     ));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Cancel Subscription',
                                                            style: getSemiBoldStyle(
                                                                color:
                                                                    ColorManager
                                                                        .redColor,
                                                                fontSize:
                                                                    FontSize
                                                                        .s10),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  20.ph,
                                                ]),
                                          ),
                                        ),

                                        20.ph,
                                        // if (selectDistrict != null) ...[
                                        //   MyButton(
                                        //       onPressed: () {
                                        //         var data = {
                                        //           "district_id":
                                        //               selectDistrict.districtId,
                                        //           "id": activeSubscription.id
                                        //         };

                                        //         ref
                                        //             .read(yourAreaController
                                        //                 .notifier)
                                        //             .updateDistrict(
                                        //                 data: data,
                                        //                 ref: ref,
                                        //                 context: context);
                                        //       },
                                        //       title: 'Update Area')
                                        // ],
                                      ],
                                    ),
                                  );
                                }),
                            error: (error, s) => Text(error.toString()),
                            loading: () => const Loader()),
                      ],
                    ),
                  );
                }
              });
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => Loader()));
  }
}

int getDaysForMonths(int months) {
  DateTime today = DateTime.now();
  DateTime endDate = DateTime(today.year, today.month + months, today.day);

  return endDate.difference(today).inDays;
}

String getFeatures({required String planName}) {
  switch (planName.toLowerCase().trim()) {
    case 'basic':
      return 'Number of visits 4 times';

    case 'standard':
      return 'Number of visits 8 times';

    case 'premium':
      return 'Number of visits 12 times';
  }
  return '';
}

Color getColor({required String planName}) {
  switch (planName.toLowerCase().trim()) {
    case 'basic':
      return const Color.fromRGBO(81, 212, 252, 1);

    case 'standard':
      return const Color.fromRGBO(189, 53, 242, 1);

    case 'premium':
      return const Color.fromRGBO(44, 199, 83, 1);
  }
  return Colors.transparent;
}
