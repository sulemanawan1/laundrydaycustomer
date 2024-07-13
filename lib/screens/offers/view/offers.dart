import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/offers/models/subsription_plan_model.dart';
import 'package:laundryday/utils/constants/colors.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/heading.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      name: 'Basic',
      price: '50',
      duration: 60,
      features: 'Number of visits 4 times',
      color: const Color.fromRGBO(81, 212, 252, 1),
    ),
    SubscriptionPlan(
      name: 'Standard',
      price: '100',
      duration: 120,
      features: 'Number of visits 8 times',
      color: const Color.fromRGBO(189, 53, 242, 1),
    ),
    SubscriptionPlan(
      name: 'Premium',
      price: '150',
      duration: 240,
      features: 'Number of visits 12 times',
      color: const Color.fromRGBO(44, 199, 83, 1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'Offers',
          isLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Heading(title: 'Select Your Plan'),
                10.ph,
                Center(
                  child: Image.asset(
                    'assets/vectors/subscription.png',
                    height: 200,
                  ),
                ),
                20.ph,
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => 10.ph,
                    shrinkWrap: true,
                    itemCount: plans.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              10.ph,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: plans[index].color),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        plans[index].name.toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.whiteColor),
                                      ),
                                    )),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'SAR ${plans[index].price}',
                                        style: GoogleFonts.poppins(
                                            letterSpacing: 1.0,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      5.ph,
                                      TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateColor
                                                      .resolveWith((states) =>
                                                          plans[index].color)),
                                          onPressed: () {},
                                          child: Text(
                                            'Subscribe',
                                            style: GoogleFonts.poppins(
                                                color: ColorManager.whiteColor,
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        plans[index].features,
                                        style: GoogleFonts.poppins(
                                          color: ColorManager.greyColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: ColorManager.greyColor,
                                        size: 12,
                                      ),
                                      5.pw,
                                      Text(
                                        '${plans[index].duration} Days',
                                        style: GoogleFonts.poppins(
                                            color: ColorManager.greyColor,
                                            fontWeight: FontWeight.w400,
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
                      );
                    },
                  ),
                ),
              ]),
        ));
  }
}
