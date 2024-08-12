import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundryday/config/resources/colors.dart';
import 'package:laundryday/config/resources/sized_box.dart';
import 'package:laundryday/config/resources/value_manager.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';
import 'package:laundryday/core/widgets/my_button.dart';
import 'package:laundryday/core/widgets/heading.dart';

class PaymentOptions extends StatelessWidget {
  const PaymentOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Payment Options',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.ph,
            const Heading(title: 'My Cards'),
            20.ph,
            ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: ColorManager.whiteColor,
                  child: ListTile(
                    leading: Image.asset(
                      'assets/visa.png',
                      height: 20,
                    ),
                    title: Text('Suleman Abrar'),
                    subtitle: Text('Ending with ${3886}'),
                  ),
                );
              },
            ),
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
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryColor,
                      fontSize: 16,
                      
                    ),
                  ),
                ],
              )),
              title: '',
              onPressed: () {
                context.pushNamed(RouteNames().addNewCard);
              },
            )
          ],
        ),
      ),
    );
  }
}
