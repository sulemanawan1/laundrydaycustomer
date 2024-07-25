import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/screens/order_review/order_review.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/routes/route_names.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/core/widgets/heading.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.ph,
            const Heading(title: "Payment Method"),
            5.ph,
            InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  builder: (BuildContext context) {
                    return Consumer(builder: (context, reff, child) {
                      final states = reff.watch(orderReviewProvider);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            10.ph,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeadingMedium(title: 'Choose payment method'),
                                IconButton(
                                    onPressed: () {
                                      context.pop();
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
                                itemCount: states.paymentMethods.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: ColorManager.primaryColor)),
                                    child: ListTile(
                                      onTap: () {
                                        reff
                                            .read(orderReviewProvider.notifier)
                                            .selectIndex(index: index);
                                      },
                                      trailing: Image.asset(
                                        states.paymentMethods[index].icon
                                            .toString(),
                                        height: 20,
                                      ),
                                      leading: Wrap(children: [
                                        (states.paymentSelectedIndex == index)
                                            ? Icon(
                                                Icons.check_circle_rounded,
                                                color:
                                                    ColorManager.primaryColor,
                                              )
                                            : const Icon(Icons.circle_outlined),
                                        10.pw,
                                        Heading(
                                            title: states
                                                .paymentMethods[index].name
                                                .toString())
                                      ]),
                                    ),
                                  );
                                },
                              ),
                            ),
                            5.ph,
                            MyButton(
                              isBorderButton: true,
                              widget: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add_circle_outline),
                                  5.pw,
                                  Text(
                                    'Add New Debit/Credit',
                                    style: GoogleFonts.poppins(
                                      color: ColorManager.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )),
                              title: '',
                              onPressed: () {
                                context.pushNamed(RouteNames().addNewCard);
                              },
                            ),
                            10.ph,
                            MyButton(
                              title: 'Select Method',
                              onPressed: () {
                                context.pop();
                              },
                            ),
                            20.ph
                          ],
                        ),
                      );
                    });
                  },
                );
              },
              child: Row(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/credit_card.png',
                        width: 50,
                        height: 20,
                      ),
                      10.pw,
                      HeadingMedium(title: 'Card Payment')
                    ],
                  ),
                  const Spacer(),
                  Heading(
                    color: ColorManager.primaryColor,
                    title: 'Change',
                  )
                ],
              ),
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}
