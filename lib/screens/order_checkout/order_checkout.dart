import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/constants/sized_box.dart';
import 'package:laundryday/core/routes/route_names.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/payment_method_widget.dart';
import 'package:laundryday/core/widgets/payment_summary_widget.dart';

class OrderCheckout extends ConsumerStatefulWidget {
  const OrderCheckout({super.key});

  @override
  ConsumerState<OrderCheckout> createState() => _OrderCheckoutState();
}

class _OrderCheckoutState extends ConsumerState<OrderCheckout> {
  @override
  Widget build(BuildContext context) {
    // final selectedItems = ref.watch(selectedItemNotifier);
    return Scaffold(
      appBar: MyAppBar(
        title: 'Checkout',
        actions: [
          InkWell(
            onTap: () {
              context.pushNamed(RouteNames().invoice);
            },
            child: Row(
              children: [
                const Icon(Icons.receipt),
                Text(
                  'Invoice',
                  style: GoogleFonts.poppins(color: ColorManager.primaryColor),
                )
              ],
            ),
          ),
          10.pw,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // OrderItemWidget(items: selectedItems),
            10.ph,
            const PaymentMethodWidget(),
            10.ph,
            PaymentSummaryWidget(),
            10.ph,
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(40),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: ColorManager.blackColor,
                    borderRadius: BorderRadius.circular(40)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pay with',
                      style: GoogleFonts.poppins(
                        color: ColorManager.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.pw,
                    Image.asset(
                      'assets/icons/apple_pay.png',
                      color: ColorManager.whiteColor,
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
