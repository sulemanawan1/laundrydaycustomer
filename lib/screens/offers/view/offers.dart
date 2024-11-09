import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/models/address_model.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/screens/offers/provider/offers_notifier.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:laundryday/widgets/heading.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_loader.dart';
import 'package:location/location.dart';

class Offers extends ConsumerWidget {
  Offers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(fetchUserProvider);
    final subscriptionPlans = ref.watch(subscriptionPlanProvider);

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
                                        horizontal: 10),
                                    itemCount: r.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var plan = r.data![index];
                                      return GestureDetector(
                                        onTap: () async {
                                          context.pushNamed(
                                              RouteNames.subscriptionLaundry,
                                              extra: 'Alhazm');
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
                  return Text("You are Subscriber");
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
