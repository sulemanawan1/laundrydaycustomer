import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/widgets/address_detail_widget.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/core/widgets/heading.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Order Summary'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(
                child:
                    Heading(title: '''You've request order from anywhere ''')),
            10.ph,
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0,
                child: Column(children: [
                  10.ph,
                  const Text("Order ID - 112234"),
                  const Text('Placed on Feb 22,2024 13:02 pm'),
                  10.ph,
                ]),
              ),
            ),
            10.ph,
            const Heading(title: 'Order Details'),
            20.ph,
            HeadingMedium(title: 'Address Details'),
            10.ph,
            AddressDetailCard(
              origin: '',
              destination: '',
            ),
            10.ph,
            HeadingMedium(title: 'Order Details'),
            10.ph,
            const OrderDetailAddressWidget(),
            10.ph,
            HeadingMedium(title: 'Delivery Status'),
            10.ph,
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.ph,
                        HeadingMedium(
                          title: 'Cancel',
                          color: Colors.red,
                        ),
                        10.ph,
                      ]),
                ),
              ),
            ),
            20.ph,
            MyButton(
              title: 'Order Chat',
              isBorderButton: true,
              onPressed: () {
                context.pushNamed(RouteNames().orderChat);
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class OrderDetailAddressWidget extends StatelessWidget {
  const OrderDetailAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ColorManager.whiteColor,
      title: const Text('Al Rahden'),
      leading: const CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('assets/al_rahden.png'),
      ),
    );
  }
}
